#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
suppressPackageStartupMessages(c(
        library(shinythemes),
        library(shiny),
        library(tm),
        library(stringr),
        library(markdown),
        library(stylo)))

shinyUI(navbarPage("Coursera Data Science Capstone", 
                   
                   theme = shinytheme("flatly"),
                   
 
## Tab 1 - Prediction

tabPanel("Next Word Prediction",
         
tags$head(includeScript("./js/ga-shinyapps-io.js")),
         
         fluidRow(
                 
        column(3),
         column(6,
         tags$div(textInput("text", 
        label = h3("Enter your text here:"),
        value = ),
        tags$span(style="color:grey",("Only English words are supported.")),
        br(),
        tags$hr(),
        h4("The predicted next word:"),
        tags$span(style="color:darkred",
        tags$strong(tags$h3(textOutput("predictedWord")))),
        br(),
        tags$hr(),
        h4("What you have entered:"),
         tags$em(tags$h4(textOutput("enteredWords"))),
        align="center")
        ),
         column(3)
         )
),

tabPanel("About This Application",
         fluidRow(
        column(2,
        p("")),
         column(8,
        includeMarkdown("./about/about.md")),
        column(2,
         p(""))
         )
),
                         
                         tags$hr(),
                         
        tags$br(),
                         
        tags$span(style="color:black", 
        tags$footer(("© 2016 - "), 
        tags$a(style="color:grey",
                                                 #,
        target="_blank",
         "Jeff Sheremata."), 
        tags$br(),
        ("Built with"), tags$a(
         style="color:green",
         href="http://www.r-project.org/",
          target="_blank",
         "R"),
        ("&"), tags$a(
         style="color:green",
          href="http://shiny.rstudio.com",
         target="_blank",
         "Shiny."),
        align = "center"),
                                   
        tags$br()
         )
                         
