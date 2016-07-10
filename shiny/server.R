#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(tm)
library(stringr)
library(markdown)
library(rsconnect)
library(qdap)
#library(stylo)
#showLogs(streaming = TRUE)
options(shiny.maxRequestSize=30*1024^2) 

# Define server logic required to draw a histogram



shinyServer(function(input, output,session) {
  
  #source("~/Desktop/Rfolder/final/en_US/shinytext/M_P_W.R")
  source("M_P_W.R")
  #tdm2<-readRDS(file="US_tdm_2_df_1_new2j.RData")
  #tdm3<-readRDS(file="US_tdm_3_df_1_new2j.RData")
  #tdm4<-readRDS(file="US_tdm_4_df_1_new2j.RData")
  tdm2<-readRDS(file="finalbigramsj.RData")
  tdm3<-readRDS(file="finaltrigramsj.RData")
  tdm4<-readRDS(file="finalquadgramsjalt2.RData")
  
  observe({
    
    
  #wordprediction<-reactive({
    #input$text})
  
          #output$predictedWord<-renderPrint({
  #if(nchar(input$text) > 4) {
    inputText<-eventReactive(input$go,{as.character(input$text)})
    #wordPrediction <-"No"
     wordPrediction <- reactive({
       
              #inputText<-as.character(input$text)
              textInput <- Clean_Text2(inputText())
             #print(textInput)
              jeff<-M_P_W_e(textInput,tdm2,tdm3,tdm4)
              #jeff<-textInput
              #wordPrediction <-as.character
              #wordPrediction_wc<-length(wordPrediction)
              })

   
  #}
     wordPrediction_wc<-reactive({length(wordPrediction())})
     
     #output$predictedWord<-renderText({wordPrediction})
  #output$predictedWord <- renderPrint({ input$text }, quoted = FALSE)
  output$predictedWord<-renderPrint(cat(wordPrediction()[1], sep=", \n"))
  if (wordPrediction_wc()>1&wordPrediction_wc()<6){
  #if (wordPrediction_wc()<6){
    output$otherWords<-renderPrint(cat(wordPrediction()[2:wordPrediction_wc()], sep=", \n"))
  }
    if (wordPrediction_wc()==1){
    output$otherWords<-renderPrint(cat("the algorithm did not find any prediction matches", sep=", \n"))
  }
  
      if (wordPrediction_wc()==0){
    output$predictedWord<-renderPrint(cat("the algorithm did not find any  matches", sep=", \n"))
    output$otherWords<-renderPrint(cat("the algorithm did not find any  matches", sep=", \n"))
  }
  #output$enteredWords <- renderText({ input$text }, quoted = FALSE)
  #output$enteredWords <- renderText({ inputText }, quoted = FALSE)
})
})