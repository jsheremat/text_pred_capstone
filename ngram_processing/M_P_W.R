

M_P_W2 <- function(text_enter,tdm) {
bob<-tdm[tdm$firstword==text_enter,]
#chris<-as.vector(bob$freq)/sum(as.vector(bob$freq))
#mike<-sample(x=bob$lastword,size=4,prob=bob$lastword)
M_P_W<-"na"
bo<-dim(bob)[1]
stp<-5
if (bo<5&bo>0){
  stp=bo
}
#M_P_W [1]<-bob[1,"lastword"]
#M_P_W [2]<-bob[2,"lastword"]
#M_P_W [3]<-bob[3,"lastword"]
#M_P_W [4]<-bob[4,"lastword"]
place=1
M_P_W=NULL
if (bo>0){
for (i in 1:stp) {
  
  if (bob[place,"lastword"]=="na") {
    place=place+1
    M_P_W [i]<-bob[place,"lastword"]
  } else {
    M_P_W [i]<-bob[place,"lastword"]
    place=place+1
  }
}
}
return (M_P_W)
}


Clean_Text2 <- function(textinput) {
  library(qdap)
  text_sample1<-tolower(textinput) 
  text_sample1<-str_replace_all(text_sample1, pattern="[[:punct:]]","") 
  #text_sample1<--str_replace_all(text_sample1, pattern="\\s+", " ") 
  text_sample1 <-removeNumbers(text_sample1) 
  text_sample1 <-rm_stopwords(text_sample1, stopwords =stopwords("english")) 
  if (is.null(character_count(text_sample1))){
    text_sample1<-"the"
  }
  return (text_sample1)
}

M_P_W_e <- function(textinput,US_tdm_2_df_1_new2,US_tdm_3_df_1_new2,US_tdm_4_df_1_new2) {

library(qdap)
library(stringr)
clean_text<-Clean_Text2(textinput)
text_length<-wc(as.character(clean_text))
ul<-unlist(clean_text)
ul2<-str_c(ul,collapse=' ')
clean_text2<-ul2
#MPWo<-NULL
clean_text
text_length

if (text_length==1){
  MPWo<-M_P_W2(clean_text2,US_tdm_2_df_1_new2)  
} 

text_length

if (text_length==2){
  MPWo<-M_P_W2(clean_text2,US_tdm_3_df_1_new2)
  if ((length(MPWo)<5)&(length(MPWo)>0)) {
    MPWalt<-M_P_W2(word(clean_text2,-1),US_tdm_2_df_1_new2)
    MPWo<-c(MPWo,MPWalt)
  }
  if (is.null(MPWo)){
    MPWo<-M_P_W2(word(clean_text2,-1),US_tdm_2_df_1_new2)
    MPalt<-M_P_W2(word(clean_text2,-1),US_tdm_2_df_1_new2)
  }
  #
} 

if (text_length>2){
  ul3<-str_c(word(clean_text2,-3:-1),collapse=' ')
 MPWo<-M_P_W2(ul3,US_tdm_4_df_1_new2)
 
 
 if ((length(MPWo)<5)&(length(MPWo)>0)) {
   
   ul3<-str_c(word(clean_text2,-2:-1),collapse=' ')
   MPWalt<-M_P_W2(ul3,US_tdm_3_df_1_new2)
   
   MPWo<-c(MPWo,MPWalt)
 }
 
 if ((length(MPWo)<5)&(length(MPWo)>0)) {
   MPWalt<-M_P_W2(word(clean_text2,-1),US_tdm_2_df_1_new2)
  
   MPWo<-c(MPWo,MPWalt)
 }
  #
  #MPalt<-M_P_W2(word(clean_text2,-1),US_tdm_2_df_1_new2)
  if (is.null(MPWo)) {
    #ul4<-word(clean_text2,-2:-1)
    ul4<-str_c(word(clean_text2,-2:-1),collapse=' ')
    MPWo<-M_P_W2(ul4,US_tdm_3_df_1_new2)
  
    MPalt<-M_P_W2(word(clean_text2,-1),US_tdm_2_df_1_new2)
  }
    ###
    if ((length(MPWo)<5)&(length(MPWo))>0) {
      MPWalt<-M_P_W2(word(clean_text2,-1),US_tdm_2_df_1_new2)
     
      MPWo<-c(MPWo,MPWalt)
    }
    ###
#}

  if (is.null(MPWo)) {
  MPWo<-M_P_W2(word(clean_text2,-1),US_tdm_2_df_1_new2)

}

}
#}

#}
MPWo<-unique(MPWo)
return (MPWo)
}
