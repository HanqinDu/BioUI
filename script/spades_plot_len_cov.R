args <- commandArgs(TRUE)
info.path <- args[1]
cov.den.path <- args[2]
len.den.path <- args[3]

library(ggplot2)
library(svglite)
library(scales)

table <- read.csv(info.path)

ggsave(cov.den.path, width = 7, height = 5.5,
  ggplot(table, aes(log2(coverage))) +
  geom_density() +
  xlab("coverage") +
  scale_x_continuous(
    labels = trans_format("identity", function(x) 2^x),
    breaks = function(x){
      return(ceiling(x[1]):floor(x[2]))
    }
  )
)

ggsave(len.den.path, width = 7, height = 5.5,
  ggplot(table, aes(log2(length))) +
  geom_density() +
  xlab("length") +
  scale_x_continuous(
    labels = trans_format("identity", function(x) 2^x),
    breaks = function(x){
      return(ceiling(x[1]):floor(x[2]))
    }
  )
)

