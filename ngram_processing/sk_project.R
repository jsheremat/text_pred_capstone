
```{r}
library(tm)
library(stringi)
library(knitr)
library(RWeka)
library(wordcloud)
library(ggplot2)
library(qdap)
library(stringr)

#Read in the text data
setwd("~/Desktop/Rfolder/final/en_US")

con<-file("./en_US.twitter.txt","r")
twitter<-readLines(con,skipNul=TRUE)
close(con)

con<-file("./en_US.blogs.txt","r")
blogs<-readLines(con,skipNul=TRUE)
close(con)

con<-file("./en_US.news.txt","r")
news<-readLines(con,skipNul=TRUE)
close(con)

set.seed(1)

#Sample the text data
twitter_cleaned<-iconv(twitter,"UTF-8","ASCII","byte")
blogs_cleaned<-iconv(blogs,"UTF-8","ASCII","byte")
news_cleaned<-iconv(news,"UTF-8","ASCII","byte")

samplebloga=rbinom(length(blogs_cleaned),1,0.03)
sampleblogb=rbinom(length(blogs_cleaned),1,0.03)
sampleblogc=rbinom(length(blogs_cleaned),1,0.03)
sampleblogd=rbinom(length(blogs_cleaned),1,0.03)
sampleblog1<-blogs_cleaned[samplebloga==1]
sampleblog2<-blogs_cleaned[(samplebloga==0)&(sampleblogb==1)]
sampleblog3<-blogs_cleaned[(samplebloga==0)&(sampleblogb==0)&(sampleblogc==1)]
sampleblog4<-blogs_cleaned[(samplebloga==0)&(sampleblogb==0)&(sampleblogc==0)&&(sampleblogd==1)]

samplenewsa=rbinom(length(news_cleaned),1,0.03)
samplenewsb=rbinom(length(news_cleaned),1,0.03)
samplenewsc=rbinom(length(news_cleaned),1,0.03)
samplenewsd=rbinom(length(news_cleaned),1,0.03)
samplenews1<-news_cleaned[samplenewsa==1]
samplenews2<-news_cleaned[(samplenewsa==0)&(samplenewsb==1)]
samplenews3<-news_cleaned[(samplenewsa==0)&(samplenewsb==0)&(samplenewsc==1)]
samplenews4<-news_cleaned[(samplenewsa==0)&(samplenewsb==0)&(samplenewsc==0)&&(samplenewsd==1)]

#samplenews3<-jack[(samplenews==0)&(samplenews2==1)]

sampletwittera=rbinom(length(twitter_cleaned),1,0.03)
sampletwitterb=rbinom(length(twitter_cleaned),1,0.03)
sampletwitterc=rbinom(length(twitter_cleaned),1,0.03)
sampletwitterd=rbinom(length(twitter_cleaned),1,0.03)
sampletwitter1<-twitter_cleaned[sampletwittera==1]
sampletwitter2<-twitter_cleaned[(sampletwittera==0)&(sampletwitterb==1)]
sampletwitter3<-twitter_cleaned[(sampletwittera==0)&(sampletwitterb==0)&(sampletwitterc==1)]
sampletwitter4<-twitter_cleaned[(sampletwittera==0)&(sampletwitterb==0)&(sampletwitterc==0)&&(sampletwitterd==1)]

textsample1<-paste(sampleblog1,samplenews1,sampletwitter1)
textsample2<-paste(sampleblog2,samplenews2,sampletwitter2)
textsample3<-paste(sampleblog3,samplenews3,sampletwitter3)
textsample4<-paste(sampleblog4,samplenews4,sampletwitter4)

corpus1 <- Corpus(VectorSource(list(textsample1)))
corpus2 <- Corpus(VectorSource(list(textsample2)))
corpus3 <- Corpus(VectorSource(list(textsample3)))
corpus4 <- Corpus(VectorSource(list(textsample4)))

#Clean up the text samples
corpus_clean1 <- Clean_Text(corpus1)
corpus_clean2 <- Clean_Text(corpus2)
corpus_clean3 <- Clean_Text(corpus3)
corpus_clean4 <- Clean_Text(corpus4)

#Create the ngrams
BigramTokenizer<-function(x) {NGramTokenizer(x,Weka_control(min=2,max=2))}
TrigramTokenizer<-function(x) {NGramTokenizer(x,Weka_control(min=3,max=3))}
QuartgramTokenizer<-function(x) {NGramTokenizer(x,Weka_control(min=4,max=4))}

tdm_2<-tm::TermDocumentMatrix(corpus_clean, control=list(tokenize=BigramTokenizer,wordLengths = c(3, Inf)))
tdm_2_freq <- rowSums(as.matrix(tdm_2))
tdm_2_df <- data.frame(word=names(tdm_2_freq), freq=tdm_2_freq)
saveRDS(tdm_2_df_1, "tdm_2_df_1j.RData")

tdm_3<-tm::TermDocumentMatrix(corpus_clean, control=list(tokenize=TrigramTokenizer,wordLengths = c(3, Inf)))
tdm_3_freq <- rowSums(as.matrix(US_tdm_3))
tdm_3_df <- data.frame(word=names(US_tdm_3_freq), freq=US_tdm_3_freq)

tdm_4<-tm::TermDocumentMatrix(corpus_clean, control=list(tokenize=QuartgramTokenizer,wordLengths = c(3, Inf)))
tdm_4_freq <- rowSums(as.matrix(US_tdm_4))
tdm_4_df <- data.frame(word=names(US_tdm_4_freq), freq=US_tdm_4_freq)

US_tdm_2_df$firstword<-word(US_tdm_2_df$word)
US_tdm_2_df$lastword<-word(US_tdm_2_df$word,-1)
US_tdm_2_df_1<-US_tdm_2_df[order(US_tdm_2_df$firstword, US_tdm_2_df$freq, decreasing=TRUE),]
US_tdm_2_df_1_new<-DF_pos(US_tdm_2_df_1)
US_tdm_2_df_1_new2<-US_tdm_2_df_1_new[US_tdm_2_df_1_new$pos<6,] 
#US_tdm_2_df_1_new2<-US_tdm_2_df_1_new[US_tdm_2_df_1$freq>1,] one or the other
saveRDS(US_tdm_2_df_1_new2, "US_tdm_2_df_1_new2j.RData")

#Combine the text samples into a single data frame
#Process the dataframes.  Divide each ngram into the first (n-1) words and the last word
#Determine the statistical liklihood of each of the last words being sampled
#The five most likely word samples are identified
a<-tdm_2_freq_1
b<-tdm_2_freq_2
c<-tdm_2_freq_3
d<-c(a,b,c)
e<-data.frame(word=names(d),freq=d)
f<-aggregate(e$freq,by=list(word=e$word),FUN=sum)
f$firstword<-word(f$word)
f$lastword<-word(f$word,-1)
names(f)[2]="freq"
g<-f[order(f$firstword,f$freq, decreasing=TRUE),]
h<-DF_pos(g)
i<-h[h$pos<6,]
j<-i[,c("freq","firstword","lastword","pos")]
saveRDS(j, "finalbigramsj.RData")


US_tdm_3_df$firstword<-word(US_tdm_3_df$word,start=1,end=2)
US_tdm_3_df$lastword<-word(US_tdm_3_df$word,-1)
US_tdm_3_df_1<-US_tdm_3_df[order(US_tdm_3_df$firstword, US_tdm_3_df$freq, decreasing=TRUE),]
US_tdm_3_df_1_new<-DF_pos(US_tdm_3_df_1)
US_tdm_3_df_1_new2<-US_tdm_3_df_1_new[US_tdm_3_df_1_new$pos<6,] 
#US_tdm_3_df_1_new2<-US_tdm_3_df_1_new[US_tdm_3_df_1$freq>1,] one or the other
saveRDS(US_tdm_3_df_1_new2, "US_tdm_3_df_1_new2j.RData")

US_tdm_4_df$firstword<-word(US_tdm_4_df$word,start=1,end=3)
US_tdm_4_df$lastword<-word(US_tdm_4_df$word,-1)
US_tdm_4_df_1<-US_tdm_4_df[order(US_tdm_4_df$firstword, US_tdm_4_df$freq, decreasing=TRUE),]
US_tdm_4_df_1_new<-DF_pos(US_tdm_4_df_1)
US_tdm_4_df_1_new2<-US_tdm_4_df_1_new[US_tdm_4_df_1_new$pos<6,] 
#US_tdm_4_df_1_new2<-US_tdm_4_df_1_new[US_tdm_4_df_1$freq>1,] one or the other
saveRDS(US_tdm_4_df_1_new2, "US_tdm_4_df_1_new2j.RData")

