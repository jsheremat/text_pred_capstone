Clean_Text2 <- function(textinput) {
  library(qdap)
  text_sample1<-tolower(textinput) 
  text_sample1<-str_replace_all(text_sample1, pattern="[[:punct:]]","") 
  #text_sample1<--str_replace_all(text_sample1, pattern="\\s+", " ") 
  text_sample1 <-removeNumbers(text_sample1) 
  text_sample1 <-rm_stopwords(CT, stopwords =stopwords("english")) 
  #text_sample1 <- 
  return (text_sample1)
}