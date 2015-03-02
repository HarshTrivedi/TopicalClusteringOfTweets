library("twitteR")
library("tm")

hashtag <- "something"
number_of_tweets <- 500
relative_path <- paste(folder , hashtag  , ".txt", sep = "")
folder <- "data/"
full_path <- paste(getwd() , relative_path , sep="/")


api_key 			<- "PwQ4G1L6gKueisgB8WolXm9L8"
api_secret 			<- "YGa7Ft7mMp2UffmIgkqo7unhAwgzwnJkMxGys4uDY1zAvxw9BL"
access_token 		<- "857731728-ZiUnNls1tEQpnJR6Rp3hNCO350EBiMWzfJkbRERh"
access_token_secret <- "QsLW3Eyymkb3I5AUXOr8GmepfZDhOGubEDd9OdEXyz8IC"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

data_list <- searchTwitter(paste("#" , hashtag , sep = ""), n=number_of_tweets )
data_text <- sapply(data_list, function(x) x$getText())

write.table(data_text, full_path , sep = " --> ")

# r_stats_text_corpus <- Corpus(VectorSource(r_stats_text))


