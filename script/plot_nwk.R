args <- commandArgs(TRUE)

library(ggplot2)
library(ggtree)
library(ape)
library(svglite)

setwd(args [1])

if(!dir.exists("Plot")){
  dir.create("Plot")
}


for(path in args[2:length(args)]){
  tree <- read.tree(path)
  filename <- sub(".*/", "", path)
  plot.tree <- ggtree(tree) + geom_treescale() + geom_tiplab()
  plot.tree <- plot.tree + ggplot2::xlim(0, max(plot.tree$data$x)*2)
  ggsave(paste0("Plot/", filename, ".svg"), plot.tree,
         height = 3 + length(tree$tip.label)*0.15, width = 5 + length(tree$tip.label)*0.1, limitsize = FALSE)
}


