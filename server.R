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
<<<<<<< HEAD
=======
  output$squirrel_plot2 <- renderPlot({ 
    central_park_attitude %>%
      filter(did_attitude == TRUE) %>%
      count(attitude) %>%                                    # count per attitude
      mutate(pct = n / sum(n),                               # calculate proportion
             label = scales::percent(pct, accuracy = 1)) %>% # e.g. "45%"
      ggplot(aes(x = "", y = pct, fill = attitude)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +                             # this turns bar into pie
      geom_text(aes(label = label),
                position = position_stack(vjust = 0.5),      # centers labels in slices
                color = "white", fontface = "bold", size = 5) +
      labs(title = "Squirrel Attitude when Approached", fill = "Attitude") +
      theme_void() +                                         # removes axes/gridlines
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        legend.title = element_text(face = "bold")
      )
  })
  

>>>>>>> 2ad62922310998540f5bb97c4ca5984266571d4b
}

