args <- commandArgs(TRUE)
library(dplyr)

seperate.pattern <- args[1]
trim.left <- as.integer(args[2])
trim.right <- as.integer(args[3])

setwd(args [1])
map <- read.csv(args[2], header = FALSE)
names(map) <- c("seq.id", "type")

for(path in args[3:length(args)]){
  alignment <- read.csv(path)
  output <- left_join(alignment, map, by = c("Subject.Seq.id" = "seq.id"))
  output <- output[,c(1,2,14,3:13)]
  write.csv(output, path, row.names = FALSE)
}
