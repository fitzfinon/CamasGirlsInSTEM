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
  select(matches("testCondition|concussionHx|sport|gender|age|height|mass|swayArea")) %>% 
  mutate(age = factor(trunc(age)),
         swayArea = round(swayArea, digits = 2))
xvar <- names(data) %>% .[. != "swayArea"]
xcont <- c("height", "mass")
xcat <- xvar %>% .[!(xvar %in% xcont)]

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  title = "Plot: Balance lab data",
  
  plotOutput('plot'),
  
  hr(),
  
  fluidRow(
    column(3, h4("Balance lab data")),
    column(3, selectInput('x', 'X', xvar)),
    column(3, selectInput('color', 'Color', c('None', xcat)))
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$plot <- renderPlot({
    
    G <- 
      data %>% 
      ggplot(aes_string(x = input$x)) + 
      scale_y_continuous("Sway Area") +
      theme_bw()
    
    if (input$x %in% xcat) {
      G <- G + geom_boxplot(aes(y = swayArea), alpha = 1/4)
    }
      
    if (input$x %in% xcont) {
      G <- 
        G + 
        geom_point(aes(y = swayArea), alpha = 1/2, size = 3) +
        geom_smooth(aes(y = swayArea), method = "lm", se = FALSE)
    }
      
    if (input$color != 'None') {
      G <- 
        G + 
        aes_string(color = input$color, fill = input$color) +
        scale_color_brewer(palette = "Set1") +
        scale_fill_brewer(palette = "Set1")
    }
    
    print(G)
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

