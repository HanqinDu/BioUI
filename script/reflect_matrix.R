args <- commandArgs(TRUE)
setwd(args[1])
matrix_path <- args[2]

matrix <- read.csv(matrix_path, header = TRUE)

if(nrow(matrix) == ncol(matrix)){
  rownames(matrix) <- colnames(matrix)
}

while(nrow(matrix) > ncol(matrix)){
  col.names(matrix) <- matrix[1,]
  matrix[1,] <- NULL
}

while(ncol(matrix) > nrow(matrix)){
  row.names(matrix) <- matrix[,1]
  matrix[,1] <- NULL
}

for(i in 2:nrow(matrix)){
  for(j in 1:(i-1)){
    if(is.na(matrix[i,j])){
      matrix[i,j] <- matrix[j,i]
    }else if(is.na(matrix[j,i])){
      matrix[j,i] <- matrix[i,j]
    }
  }
}

write.csv(matrix, paste0("reflect_", matrix_path))


