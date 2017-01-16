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
library(ggplot2)
library(RColorBrewer)


source("read.R")

data <-
  df %>% 
  select(matches("testCondition|concussionHx|sport|gender|age|swayArea")) %>% 
  mutate(age = factor(trunc(age)),
         swayArea = round(swayArea, digits = 2))
xvar <- names(data) %>% .[. != "swayArea"]

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  title = "Boxplots: Balance lab data",
  
  plotOutput('plot'),
  
  hr(),
  
  fluidRow(
    column(3,
           h4("Balance lab data"),
           selectInput('x', 'X', xvar),
           selectInput('color', 'Color', c('None', xvar))
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$plot <- renderPlot({
    
    G <- 
      data %>% 
      ggplot(aes_string(x = input$x)) + 
      geom_boxplot(aes(y = swayArea), alpha = 1/4) +
      scale_y_continuous("Sway Area") +
      theme_bw()
    
    if (input$color != 'None')
      G <- G + 
        aes_string(color = input$color, fill = input$color) +
        scale_color_brewer(palette = "Set1") +
        scale_fill_brewer(palette = "Set1")
    
    print(G)
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

