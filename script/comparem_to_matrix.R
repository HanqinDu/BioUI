library(reshape2)

df <- read.delim("output/aai/aai_summary.tsv", col.names = c("Genome.A", "Genes.in.A", "Genome.B", "Genes.in.B", "orthologous.genes", "Mean.AAI", "Std.AAI", "Orthologous.fraction"))

df1 <- df[c("Genome.A", "Genome.B", "Mean.AAI")]
df2 <- df[c("Genome.B", "Genome.A", "Mean.AAI")]
colnames(df2) <- c("Genome.A", "Genome.B", "Mean.AAI")


df.double <- rbind(df1, df2)

df.cast <- dcast(df.double, Genome.A~Genome.B, mean)
rownames(df.cast) <- df.cast$Genome.A
df.cast$Genome.A <- NULL

write.csv(df.cast, "output/aai/aai_matrix.csv")
