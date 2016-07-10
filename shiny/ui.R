#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

ui <- shinyUI(navbarPage("Coursera Data Science Capstone", 
                         
                         theme = shinytheme("flatly"),
                         
                         ############################### ~~~~~~~~1~~~~~~~~ ##############################  
                         ## Tab 1 - Prediction
                         
                         tabPanel("Next Word Prediction",
                                  
                                  
                                  fluidRow(
                                    
                                    column(3),
                                    column(6,
                                           tags$div(textInput("text", 
                                                              label = h3("Enter your text here:"),
                                                              value = ),
                                                    tags$span(style="color:grey",("When you are finished typing click here.")),
                                                    actionButton(inputId = "go", label = "Submit"),
                                                    br(),
                                                    tags$hr(),
                                                    #actionButton(inputId = "go", label = "Submit"),
                                                    h4("The predicted next word:"),
                                                    tags$span(style="color:darkblue",
                                                              tags$strong(tags$h3(textOutput("predictedWord")))),
                                                    br(),
                                                    tags$hr(),
                                                    h4("Other probable words:"),
                                                    tags$em(style="color:darkblue",tags$h4(textOutput("otherWords"))),
                                                    align="center")
                                    ),
                                    column(3)
                                  )
                         ),
                         
                         ############################### ~~~~~~~~2~~~~~~~~ ##############################
                         ## Tab 2 - About 
                         
                         tabPanel("About This Application",
                                  fluidRow(
                                    column(2,
                                           p("")),
                                    column(8,
                                           includeMarkdown("Readme.Rmd")),
                                    column(2,
                                           p(""))
                                  )
                         ),
                         
                         ############################### ~~~~~~~~F~~~~~~~~ ##############################
                         

                         #################
                         tabPanel("Links",
                                  fluidRow(
                                    column(2,
                                           p("")),
                                    column(8,
                                           includeMarkdown("Links.Rmd")),
                                    column(2,
                                           p(""))
                                  )
                         ),
                         
                         ############################### ~~~~~~~~F~~~~~~~~ ##############################
                         
                         ## Footer
                         
                         tags$hr(),
                         
                         tags$br(),
                         
                         tags$span(style="color:black", 
                                   tags$footer(("© 2016 - "), 
                                               tags$a(style="color:darkblue",
                                                 #,
                                                 target="_blank",
                                                 "Jeff Sheremata."), 
                                               tags$br(),
                                               ("Built with"), tags$a(
                                                 style="color:darkblue",
                                                 href="http://www.r-project.org/",
                                                 target="_blank",
                                                 "R"),
                                               ("&"), tags$a(
                                                 style="color:darkblue",
                                                 href="http://shiny.rstudio.com",
                                                 target="_blank",
                                                 "Shiny."),

                                               
                                               align = "center"),
                                   
                                   tags$br()
                         )
                         ################                     
)
)