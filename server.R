library(shiny)
library(ggplot2)
library(tidyverse)

function(input, output) {
  output$squirrel_plot <- renderPlot({  # matches "squirrel_plot" in ui
    central_park_attitude %>%
      filter(did_attitude == TRUE) %>%
      ggplot(aes(x = attitude)) +
      geom_bar(fill = "#652A0E", width = 0.6) +
      scale_y_continuous(labels = scales::comma) +
      labs(
        y = "Number of Squirrels",
        x = "Attitude",
        title = "Squirrel Attitude when Approached"
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        axis.text = element_text(size = 11),
        axis.title = element_text(size = 12, face = "bold"),
        panel.grid.major.x = element_blank()
      )
  })
}