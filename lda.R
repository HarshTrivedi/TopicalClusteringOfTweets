library(RTextTools)
library(topicmodels)

data <- read.csv(paste( getwd() , "data" , "coarse_combined_data.csv" , sep="/")  , header=T) 
matrix <- create_matrix( as.vector(data$data_text) , language="english") 
lda <- LDA(matrix, 6)

