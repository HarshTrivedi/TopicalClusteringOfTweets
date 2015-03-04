library(RTextTools)
library(topicmodels)

data <- read.csv(paste( getwd() , "data" , "coarse_combined_data.csv" , sep="/")  , header=T) 
matrix <- create_matrix( as.vector(data$data_text) , language="english") 
lda <- LDA(matrix, 6)




#####################################
#Finding precision and recall and F1 score

c1 <- (as.list(((which(topics(lda) == 1) ))))
c2 <- (as.list(((which(topics(lda) == 2) ))))
c3 <- (as.list(((which(topics(lda) == 3) ))))
c4 <- (as.list(((which(topics(lda) == 4) ))))
c5 <- (as.list(((which(topics(lda) == 5) ))))
c6 <- (as.list(((which(topics(lda) == 6) ))))

sports <- as.list(which( data$V2 == "sports" ))
news <- as.list(which( data$V2 == "news" ))
science <- as.list(which( data$V2 == "science" ))
entertainment <- as.list(which( data$V2 == "entertainment" ))
justforfun <- as.list(which( data$V2 == "justforfun" ))
money <- as.list(which( data$V2 == "money" ))

c11 <- intersect(c1 , sports)
c12 <- intersect(c1 , news)
c13 <- intersect(c1 , science)
c14 <- intersect(c1 , entertainment)
c15 <- intersect(c1 , justforfun)
c16 <- intersect(c1 , money)

c21 <- intersect(c2 , sports)
c22 <- intersect(c2 , news)
c23 <- intersect(c2 , science)
c24 <- intersect(c2 , entertainment)
c25 <- intersect(c2 , justforfun)
c26 <- intersect(c2 , money)

c31 <- intersect(c3 , sports)
c32 <- intersect(c3 , news)
c33 <- intersect(c3 , science)
c34 <- intersect(c3 , entertainment)
c35 <- intersect(c3 , justforfun)
c36 <- intersect(c3 , money)

c41 <- intersect(c4 , sports)
c42 <- intersect(c4 , news)
c43 <- intersect(c4 , science)
c44 <- intersect(c4 , entertainment)
c45 <- intersect(c4 , justforfun)
c46 <- intersect(c4 , money)

c51 <- intersect(c5 , sports)
c52 <- intersect(c5 , news)
c53 <- intersect(c5 , science)
c54 <- intersect(c5 , entertainment)
c55 <- intersect(c5 , justforfun)
c56 <- intersect(c5 , money)

c61 <- intersect(c6 , sports)
c62 <- intersect(c6 , news)
c63 <- intersect(c6 , science)
c64 <- intersect(c6 , entertainment)
c65 <- intersect(c6 , justforfun)
c66 <- intersect(c6 , money)



positive_pairs <- choose(length(c1),2) + choose(length(c2),2) + choose(length(c3),2) + choose(length(c4),2) + choose(length(c5),2) + choose(length(c6),2)

true_positive_pairs <- 
	choose(length(c11),2) +  
	choose(length(c12),2) +  
	choose(length(c13),2) +  
	choose(length(c14),2) +  
	choose(length(c15),2) +  
	choose(length(c16),2) +  
	choose(length(c21),2) +  
	choose(length(c22),2) +  
	choose(length(c23),2) +  
	choose(length(c24),2) +  
	choose(length(c25),2) +  
	choose(length(c26),2) +  
	choose(length(c31),2) +  
	choose(length(c32),2) +  
	choose(length(c33),2) +  
	choose(length(c34),2) +  
	choose(length(c35),2) +  
	choose(length(c46),2) +  
	choose(length(c41),2) +  
	choose(length(c42),2) +  
	choose(length(c43),2) +  
	choose(length(c44),2) +  
	choose(length(c45),2) +  
	choose(length(c46),2) +  
	choose(length(c51),2) +  
	choose(length(c52),2) +  
	choose(length(c53),2) +  
	choose(length(c54),2) +  
	choose(length(c55),2) +  
	choose(length(c66),2) +  
	choose(length(c61),2) +  
	choose(length(c62),2) +  
	choose(length(c63),2) +  
	choose(length(c64),2) +  
	choose(length(c65),2) +  
	choose(length(c66),2)

false_positive_pairs <- positive_pairs - true_positive_pairs

negative_pairs <- choose( length(topics(lda)) , 2) - positive_pairs


false_negative_pairs <- choose(length(sports) , 2) +
						choose(length(news) , 2) +
						choose(length(science) , 2) +
						choose(length(entertainment) , 2) +
						choose(length(justforfun) , 2) +
						choose(length(money) , 2) -
						true_positive_pairs

false_positive_pairs <- negative_pairs - false_negative_pairs


precision <- 100 * (true_positive_pairs) / (true_positive_pairs + false_positive_pairs)
recall <- 100 * (true_positive_pairs) / (true_positive_pairs + false_negative_pairs)

f1score <- (2 * precision * recall ) / (precision + recall)

#### Finding purity

purity_numerator <-	max(length(c11) , length(c12) , length(c13) , length(c14) , length(c15) , length(c16) ) +
					max(length(c21) , length(c22) , length(c23) , length(c24) , length(c25) , length(c26) ) +
					max(length(c31) , length(c32) , length(c33) , length(c34) , length(c35) , length(c36) ) +
					max(length(c41) , length(c42) , length(c43) , length(c44) , length(c45) , length(c46) ) +
					max(length(c51) , length(c52) , length(c53) , length(c54) , length(c55) , length(c56) ) +
					max(length(c61) , length(c62) , length(c63) , length(c64) , length(c65) , length(c66) ) 

purity_denominator <- length( length(topics(lda)) )

purity <- 100 * (purity_numerator / purity_denominator)
