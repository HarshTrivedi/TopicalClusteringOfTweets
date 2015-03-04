library(tm)

data <- read.csv(   paste( getwd() , "data" , "coarse_combined_data.csv", sep="/") ) 

tweets <- data$data_text
corpus <- Corpus(VectorSource(tweets))
corpus <- tm_map(corpus,removePunctuation)
corpus <- tm_map(corpus,stripWhitespace)
# corpus <- tm_map(corpus,tolower)
dtm <- DocumentTermMatrix(corpus) 

dtm <- removeSparseTerms(dtm, 0.95)
results <- kmeans(dtm , 6)

