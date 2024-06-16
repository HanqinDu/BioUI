args <- commandArgs(TRUE)
setwd(args [1])

# load data and Filter
df.alignment <- read.csv("blastp_result.csv", header =FALSE, col.names=c("qseqid", "sseqid", "pident", "qstart", "qend", "qlen"))

df.alignment$qcov <- abs(df.alignment$qend - df.alignment$qstart + 1) / df.alignment$qlen
df.alignment <- df.alignment[(df.alignment$qcov > 0.5 & df.alignment$pident > 40),]


# load protein count
df.protein.count <- read.csv("protein_count.csv", header =FALSE, col.names=c("qseqid", "protein.count"))


# get unique hit
pair.alignment <- df.alignment[c("qseqid", "sseqid")]
pair.alignment$sseqid <- gsub("_;.*", "", pair.alignment$sseqid)
pair.alignment <- unique(pair.alignment[c("qseqid", "sseqid")])


# calculate hit matrix
query.list <- sort(unique(pair.alignment$sseqid))
query.size <- length(query.list)

summary.hit <- data.frame(query.list)
names(summary.hit) <- "query"



for(species in query.list){
  df.temp <- data.frame(table(pair.alignment[grepl(paste0("^", species, "_;"), pair.alignment$qseqid),"sseqid"]))
  names(df.temp) <- c("query", species)
  
  summary.hit <- merge(summary.hit, df.temp, by = "query")
}


# calculate POCP from hit matrix
summary.POCP <- data.frame(matrix(nrow=query.size, ncol = query.size))
names(summary.POCP) <- query.list
rownames(summary.POCP) <- query.list

for(i in 1:query.size){
  for(j in i:query.size){
    a <- query.list[i]
    b <- query.list[j]
    
    summary.POCP[i,j] <- (summary.hit[summary.hit$query == a,b] + summary.hit[summary.hit$query == b,a]) / sum(df.protein.count[df.protein.count$qseqid %in% c(a,b), "protein.count"])
    summary.POCP[j,i] <- summary.POCP[i,j]
    
    if(i == j){
      summary.POCP[i,i] <- summary.POCP[i,i]/2
    }
  }
}


# write output
write.csv(summary.POCP, "POCP.csv")

