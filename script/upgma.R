args <- commandArgs(TRUE)
path <- args[1]
mode <- args[2]
itype <- args[3]
vline <- as.double(args[4])
task <- args[5]


library(phangorn)
library(ggtree)
library(ggplot2)
library(svglite)

dm <- read.csv(path)


if(ncol(dm) == nrow(dm)){
  rownames(dm) <- colnames(dm)
}

if(ncol(dm) > nrow(dm)){
  dif <- (ncol(dm) - nrow(dm))
  rownames(dm) <- dm[,dif]
  dm <- dm[,(dif+1):ncol(dm)]
}

if(ncol(dm) < nrow(dm)){
  dif <- (nrow(dm) - ncol(dm))
  colnames(dm) <- unlist(dm[dif,])
  dm <- dm[(dif+1):nrow(dm),]
}

if(itype == "similarity"){
  dm <- max(dm) - dm
}

if(mode == "upgma"){
  tree <- upgma(dm)
}else{
  tree <- wpgma(dm)
}

tree$edge.length <- tree$edge.length * 2

plot.tree <- ggtree(tree) + theme_tree2() + geom_tiplab(as_ylab = T)
xaxis.length <- max(plot.tree$data$x)


if(!is.na(vline)){
  cutoff <- max(0, xaxis.length-abs(as.double(vline)))
  plot.tree <- plot.tree +
    geom_vline(xintercept = cutoff, colour = "red", alpha = 0.8) +
    scale_x_continuous(sec.axis = sec_axis( trans=~.*-1+xaxis.length)) +
    theme(axis.text.x = element_text(size = round(10+length(tree$tip.label)*0.05)))
}else{
  plot.tree <- plot.tree +
    scale_x_continuous(sec.axis = sec_axis( trans=~.*-1+xaxis.length)) +
    theme(axis.text.x = element_text(size = round(10+length(tree$tip.label)*0.05)))
}

write.tree(tree, paste0(task, "_tree.phy"))

ggsave(paste0(task, "_tree.svg"), plot.tree, height = 3 + length(tree$tip.label)*0.15, width = 5 + length(tree$tip.label)*0.1, limitsize = FALSE)

