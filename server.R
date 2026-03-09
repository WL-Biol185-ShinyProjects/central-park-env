library(shiny)
library(ggplot2)
library(tidyverse)

function(input, output) {
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
      labs(title = "Pie Chart - Squirrel Attitude when Approached by Human", fill = "Attitude") +
      theme_void() +                                         # removes axes/gridlines
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        legend.title = element_text(face = "bold")
      )
  })
  output$squirrel_plot4 <- renderPlot({
    central_park_attitude %>%
      filter(did_attitude == TRUE) %>%
      count(attitude) %>%
      ggplot(aes(x = n, y = reorder(attitude, n))) +
      geom_bar(stat = "identity", fill = "#652A0E", width = 0.5) +
      geom_text(aes(label = scales::comma(n)), hjust = -0.2, fontface = "bold") +
      scale_x_continuous(expand = expansion(mult = c(0, 0.15))) +
      labs(title = "Bar Graph - Squirrel Attitude when Approached by Human", 
           x = "Number of Squirrels", y = "Attitude") +
      theme_minimal() +
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        axis.title = element_text(face = "bold")   # makes both axis labels bold
      )
  })
  output$squirrel_plot5 <- renderPlot({ 
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
      labs(title = "Pie Chart - Squirrel Attitude when Approached by Human", fill = "Attitude") +
      theme_void() +                                         # removes axes/gridlines
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        legend.title = element_text(face = "bold")
      )
  })
  output$squirrel_plot4 <- renderPlot({
    central_park_tailbeh_obs %>%
      filter(did_tailbehavior == TRUE) %>%
      count(tailbehavior) %>%
      ggplot(aes(x = n, y = reorder(attitude, n))) +
      geom_bar(stat = "identity", fill = "#652A0E", width = 0.5) +
      geom_text(aes(label = scales::comma(n)), hjust = -0.2, fontface = "bold") +
      scale_x_continuous(expand = expansion(mult = c(0, 0.15))) +
      labs(title = "Bar Graph - Squirrel Tail Behavior", 
           x = "Number of Squirrels", y = "Tail Bevavior") +
      theme_minimal() +
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        axis.title = element_text(face = "bold")   # makes both axis labels bold
      )
  })
  
}
