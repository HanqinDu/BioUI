args <- commandArgs(TRUE)

setwd(args[1])

manifest <- read.delim("manifest.tsv", check.names=FALSE)

paste.absolute <- function(relative){
  return(paste(getwd(), "/input/", relative, sep = ""))
}

if(ncol(manifest) == 3){
  manifest[2] <- sapply(manifest[2], paste.absolute)
  manifest[3] <- sapply(manifest[3], paste.absolute)
}

if(ncol(manifest) == 2){
  manifest[2] <- sapply(manifest[2], paste.absolute)
}


write.table(manifest, "manifest.tsv", quote = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE)
