#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

setwd("~/CamasGirlsInSTEM/scripts")

library(checkpoint)
checkpoint("2017-01-01", use.knitr = TRUE)

library(shiny)
library(magrittr)
library(dplyr)


source("read.R")


# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Data table: Balance lab data"),
  
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(4,
           selectInput("sport",
                       "Sport:",
                       c("All",
                         unique(as.character(df$sport))))
    ),
    column(4,
           selectInput("concussionHx",
                       "Concussion history:",
                       c("All",
                         unique(as.character(df$concussionHx))))
    ),
    column(4,
           selectInput("gender",
                       "Gender:",
                       c("All",
                         unique(as.character(df$gender))))
    )
  ),
  # Create a new row for the table.
  fluidRow(
    DT::dataTableOutput("table")
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <-
      df %>% 
      select(matches("id|concussionHx|sport|gender|age|height|mass|testCondition|swayArea")) %>% 
      mutate(age = floor(age),
             height = round(height),
             mass = round(mass),
             swayArea = round(swayArea, digits = 2))
    if (input$sport != "All") {
      data <- data[data$sport == input$sport, ]
    }
    if (input$concussionHx != "All") {
      data <- data[data$concussionHx == input$concussionHx, ]
    }
    if (input$gender != "All") {
      data <- data[data$gender == input$gender, ]
    }
    data
  }))
  
}


# Run the application 
shinyApp(ui = ui, server = server)

