#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tidyverse)

exam <- read_csv("data/Exam_data.csv")


# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Pupils Exam Results Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "variable",
                  label = "Subject:",
                  choices = c("English" = "ENGLISH",
                              "Maths" = "MATHS",
                              "Science" = "SCIENCE"),
                  selected = "ENGLISH"),
      sliderInput(inputId = "bin",
                  label = "Number of Bins",
                  min = 5,
                  max = 20,
                  value= 10)
    ),
    mainPanel(plotOutput("distPlot"))
  )
)

# Define server logic required to draw a histogram
server <- function(input, output){
  output$distPlot <- renderPlot({
    ggplot(exam, aes_string(input$variable)) + 
      geom_histogram(bins = input$bin, color="black", fill="lightblue")
  }) 
} 

# Run the application 
shinyApp(ui = ui, server = server)

