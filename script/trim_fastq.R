args <- commandArgs(TRUE)
library(Biostrings)

seperate.pattern <- args[1]
trim.left <- as.integer(args[2])
trim.right <- as.integer(args[3])


# load fastq
R1 <- readDNAStringSet("R1.fastq", format="fastq", with.qualities=TRUE)
R2 <- readDNAStringSet("R2.fastq", format="fastq", with.qualities=TRUE)


# rename
names(R1) <- gsub(paste0(seperate.pattern, ".*$"), "", names(R1))
names(R2) <- gsub(paste0(seperate.pattern, ".*$"), "", names(R2))


# trim both sequences and qualities
R1.trimed <- subseq(R1, trim.left, trim.right)
R2.trimed <- subseq(R2, trim.left, trim.right)
R1.trimed@elementMetadata@listData$qualities <- subseq(R1.trimed@elementMetadata@listData$qualities, trim.left, trim.right)
R2.trimed@elementMetadata@listData$qualities <- subseq(R2.trimed@elementMetadata@listData$qualities, trim.left, trim.right)


# write to fastq
writeXStringSet(R1.trimed, "trimed_R1.fastq", format="fastq")
writeXStringSet(R2.trimed, "trimed_R2.fastq", format="fastq")


# write to fasta
writeXStringSet(R1.trimed, "trimed_R1.fasta", format="fasta")
writeXStringSet(R2.trimed, "trimed_R2.fasta", format="fasta")
