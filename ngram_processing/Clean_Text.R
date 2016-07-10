Clean_Text <- function(corpusq) {
  
  text_sample1w<- tm_map(corpusq, tolower)
  text_sample1w<- tm_map(text_sample1w, removePunctuation)
  text_sample1w<- tm_map(text_sample1w, removeNumbers)
  text_sample1w <- tm_map(text_sample1w, removeWords, stopwords("english"))
  text_sample1w <- tm_map(text_sample1w, stripWhitespace)
  text_sample1w <- tm_map(text_sample1w, PlainTextDocument)
  
  return (text_sample1w)
}