library("twitteR")
library("tm")
api_key 			<- "PwQ4G1L6gKueisgB8WolXm9L8"
api_secret 			<- "YGa7Ft7mMp2UffmIgkqo7unhAwgzwnJkMxGys4uDY1zAvxw9BL"
access_token 		<- "857731728-ZiUnNls1tEQpnJR6Rp3hNCO350EBiMWzfJkbRERh"
access_token_secret <- "QsLW3Eyymkb3I5AUXOr8GmepfZDhOGubEDd9OdEXyz8IC"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)


folder <- "data"
types <- c("coarse")# , "fine")

coarse_combined_data <- paste(folder , "coarse_combined_data.csv" , sep="/")
fine_combined_data <- paste(folder , "fine_combined_data.csv" , sep="/")


for(type in types){
	filename <- paste(getwd() , "data" , paste(type , "_tags.txt" , sep="") , sep="/")
	connection <- file(filename,open="r")
	lines <- readLines(connection)
	hashtags <- as.list(lines)


	for(hashtag in hashtags){
		# hashtag <- "science"
		number_of_tweets <- 3000
		relative_path <- paste(folder , type , paste(hashtag  , "csv" , sep = "."), sep = "/")
		full_path <- paste(getwd() , relative_path , sep="/")
		data_list <- searchTwitter(paste("#" , hashtag , sep = ""), n=number_of_tweets , lang = "en")
		# data_list <- strip_retweets(data_list)
		data_text <- sapply(data_list, function(x) x$getText())
		matrix <- as.data.frame( cbind(data_text , c(hashtag) )  )
		write.csv( matrix, full_path)
		if(type == "coarse")
			write.csv( matrix, coarse_combined_data ,  append = T)
		else
			write.csv( matrix, fine_combined_data ,  append = T)	
		print(paste(hashtag , "is complete!"))


	}
}
# r_stats_text_corpus <- Corpus(VectorSource(r_stats_text))