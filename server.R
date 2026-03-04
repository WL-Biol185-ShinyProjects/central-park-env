library(shiny)
library(ggplot2)
library(tidyverse)

function(input, output) {
  
  output$central_park_attitude <- renderPlot({
    
    flights %>% 
      filter(
        origin == input$airport,
        dep_time == input$time
      ) %>%
      
      ggplot(aes(dep_delay)) + geom_density()
    
  })
  
}