args <- commandArgs(TRUE)

path.csv <- paste0("csv/", list.files("csv/"))


month.stat <- args[3]
month.stat <- substr(month.stat, 1, 8)


if (!requireNamespace ("data.table", quietly = TRUE)){
  install.packages("data.table")
}

library(data.table)


# give first and last date
date.begin <- as.IDate(args[3])
date.end   <- as.IDate(args[4])

if(date.begin > date.end){
  temp <- date.end
  date.end <- date.begin
  date.begin <- temp
  rm(temp)
}

if((date.end - date.begin) > 360){
  date.end = date.begin + 360
  warning(paste0("the date span are too large, the end date is adjusted to ", date.end))
}


Sys.setlocale(category = "LC_ALL", locale = "zh_CN")




staffs <- read.csv(args[1], encoding = "GBK", stringsAsFactors = FALSE, header = TRUE)

rules  <- read.csv(args[2], encoding = "GBK", stringsAsFactors = FALSE, header = TRUE)

if(is.na(args[5])){
  rules.extra <- data.frame(matrix(nrow=0, ncol=8))
  colnames(rules.extra) <- c("type", "date", "after", "before", "check", "lafter", "lbefore", "remark")
}else{
  rules.extra  <- read.csv(args[5], encoding = "GBK", stringsAsFactors = FALSE, header = TRUE)
}


rules$after   <- as.ITime(rules$after)
rules$before  <- as.ITime(rules$before)
rules$lafter  <- as.ITime(rules$lafter)
rules$lbefore <- as.ITime(rules$lbefore)
rules$check   <- as.integer(rules$check)


rules.extra$date    <- as.IDate(rules.extra$date)
rules.extra$after   <- as.ITime(rules.extra$after)
rules.extra$before  <- as.ITime(rules.extra$before)
rules.extra$lafter  <- as.ITime(rules.extra$lafter)
rules.extra$lbefore <- as.ITime(rules.extra$lbefore)
rules.extra$check   <- as.integer(rules.extra$check)



if(any(is.na(rules$wday) | is.na(rules$after) | is.na(rules$before))){
  warning("invalid rule detected in rule: ")
  warning(paste0(as.character(read.csv(args[2], encoding = "GBK", stringsAsFactors = FALSE, header = TRUE)
                              [(is.na(rules$wday) | is.na(rules$after) | is.na(rules$before)),]), collapse=" "))
  
  rules <- rules[!(is.na(rules$wday) | is.na(rules$after) | is.na(rules$before)),]
}


if(any(is.na(rules.extra$date) | is.na(rules.extra$after) | is.na(rules.extra$before))){
  warning("invalid rule detected in extra rule: ")
  warning(paste0(as.character(read.csv(args[5], encoding = "GBK", stringsAsFactors = FALSE, header = TRUE)
                              [(is.na(rules.extra$date) | is.na(rules.extra$after) | is.na(rules.extra$before)),]), collapse=" "))
  
  rules.extra <- rules.extra[!(is.na(rules.extra$date) | is.na(rules.extra$after) | is.na(rules.extra$before)),]
}



special.date <- unique(rules.extra$date)






# type 1
load.format1 <- function(raw.sign){
  
  raw.sign <- raw.sign[,c(1,2)]
  colnames(raw.sign) <- c("name", "sign")
  
  date.time.sign <- base::strsplit(raw.sign$sign, split = " ")
  date.time.sign <- t(matrix(unlist(date.time.sign), nrow = 2))
  
  raw.sign <- cbind(raw.sign, date.time.sign)
  raw.sign$sign <- NULL
  
  colnames(raw.sign) <- c("name", "date", "time")
  
  raw.sign$date <- gsub("/", "-", raw.sign$date, fixed=TRUE)
  
  return(raw.sign)
}





# type 2
load.format2 <- function(raw.sign){
  
  temp.summary.sign <- data.frame(matrix(0, nrow = 0, ncol = 3))
  colnames(temp.summary.sign) <- c("name", "date", "time")
  
  raw.sign <- as.matrix(raw.sign)
  
  i <- 1
  
  while(i <= nrow(raw.sign)){
    row <- raw.sign[i,]
    
    match.name <- grepl("ÐÕÃû", row)
    
    if(any(match.name)){
      name <- row[which(match.name)[1]+1]
      
      i <- i+1
      if(i>nrow(raw.sign)){print("imcomplete table of type 2")}
      row.date <- raw.sign[i,]
      row.date <- gsub(" ","",row.date)
      for(k in 1:length(row.date)){
        if(!is.na(row.date[k])){
          if(nchar(row.date[k]) == 1){
            row.date[k] <- paste0("0", row.date[k])
          }
        }
      }
      
      i <- i+1
      if(i>nrow(raw.sign)){break}
      row <- raw.sign[i,]
      
      while(!any(grepl("ÐÕÃû", row))){
        for(j in 1:length(row)){
          value <- row[j]
          value <- gsub("\n", " ", value, fixed = TRUE)
          if(grepl(" $", value)){value <- gsub(" ", "", value)}
          if(!(is.na(value) || value == "" || value == "NA")){
            for(t in unlist(base::strsplit(value, split = " "))){
              temp.summary.sign[nrow(temp.summary.sign)+1,] <- c(name, paste0(month.stat, row.date[j]), t)
            }
          }
        }
        
        i <- i+1
        if(i>nrow(raw.sign)){break}
        row <- raw.sign[i,]
      }
      
    }else{
      i <- i+1
    }
  }
  
  return(temp.summary.sign)
  
}



# type 3
load.format3 <- function(raw.sign){
  temp.summary.sign <- data.frame(matrix(0, nrow = 0, ncol = 3))
  colnames(temp.summary.sign) <- c("name", "date", "time")
  
  for(i in 1:nrow(raw.sign)){
    if((nchar(raw.sign[i,1]) > 6 & (nchar(raw.sign[i,1]) < 12) & (nchar(raw.sign[i,9]) > 3))){
      temp.summary.sign[nrow(temp.summary.sign)+1,] <- c(raw.sign[i,3], gsub("/", "-", raw.sign[i,1]), raw.sign[i,9])
    }
  }
  
  return(temp.summary.sign)
  
}



summary.sign <- data.frame(matrix(0, nrow = 0, ncol = 3))
colnames(summary.sign) <- c("name", "date", "time")

for(path in path.csv){
  
  raw.sign <- read.csv(path)
  
  
  # type 1
  if(ncol(raw.sign) < 6){
    summary.sign <- rbind(summary.sign, load.format1(raw.sign))
  }
  
  # type 2
  if(ncol(raw.sign) > 13 & ncol(raw.sign) < 17){
    summary.sign <- rbind(summary.sign, load.format3(raw.sign))
  }
  
  # type 3
  if(ncol(raw.sign) > 30 & ncol(raw.sign) < 34){
    summary.sign <- rbind(summary.sign, load.format2(raw.sign))
  }
}


summary.miss <- data.frame(matrix(0, nrow = 0, ncol = 7))
colnames(summary.miss) <- c("name", "date", "after", "before", "remark", "miss", "late")

summary.sign$time <- as.ITime(summary.sign$time)
summary.sign$date <- as.IDate(summary.sign$date)


# loop staffs
for(i in 1:nrow(staffs)){
  name <- staffs$name[i]
  type <- staffs$type[i]
  
  summary.sign.name <- summary.sign[summary.sign$name == name,]
  
  # loop date
  for(d in date.begin:date.end){
    if(d %in% special.date){
      rule.temp <- rules.extra[rules.extra$type == type & rules.extra$date == d,]
    }else{
      rule.temp <- rules[rules$type == type & rules$wday == wday(d),]
    }
    
    
    # loop rule
    if(nrow(rule.temp) != 0){
      for(r in 1:nrow(rule.temp)){
        
        summary.sign.name.fit <- summary.sign.name[summary.sign.name$date == d
                                                   & summary.sign.name$time > rule.temp$after[r]
                                                   & summary.sign.name$time <= rule.temp$before[r],]
        
        # count number of sign (with at least 10min interval)
        pre.time <- -600
        count <- 0
        
        for(t in sort(summary.sign.name.fit$time)){
          if((t - pre.time) >= 10*60){
            pre.time <- t
            count <- count + 1
          }
        }
        
        if(count < rule.temp$check[r]){
          
          late.sign <- FALSE
          
          if(!is.na(rule.temp$lafter[r]) && !is.na(rule.temp$lbefore[r])){
            late.sign <- any(summary.sign.name$date == d
                             & summary.sign.name$time > rule.temp$lafter[r]
                             & summary.sign.name$time <= rule.temp$lbefore[r])
          }
          
          
          if(late.sign){
            summary.miss[nrow(summary.miss)+1,] <- c(name, 
                                                     d, 
                                                     rule.temp$after[r], 
                                                     rule.temp$before[r], 
                                                     rule.temp$remark[r], 
                                                     rule.temp$check[r]-count-1, 
                                                     1)
          }else{
            summary.miss[nrow(summary.miss)+1,] <- c(name, 
                                                     d, 
                                                     rule.temp$after[r], 
                                                     rule.temp$before[r], 
                                                     rule.temp$remark[r], 
                                                     rule.temp$check[r]-count, 
                                                     0)
          }
        }
      }
    }
  }
}


summary.miss$date   <- as.IDate(as.integer(summary.miss$date))
summary.miss$after  <- as.ITime(as.integer(summary.miss$after))
summary.miss$before <- as.ITime(as.integer(summary.miss$before))

summary.miss <- summary.miss[order(summary.miss$name, summary.miss$date, summary.miss$after),]


write.csv(summary.miss, "summary.csv", quote = FALSE, row.names = FALSE)

