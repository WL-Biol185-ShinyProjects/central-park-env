library(shiny)
library(ggplot2)
library(tidyverse)

function(input, output) {
  
  output$squirrel_plot1 <- renderPlot({
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
  
  output$squirrel_plot3 <- renderPlot({
    central_park_tailbeh_obs %>%
      filter(did_tailbehavior == TRUE) %>%
      count(tailbehavior) %>%
      ggplot(aes(x = n, y = reorder(tailbehavior, n))) +
      geom_bar(stat = "identity", fill = "#652A0E", width = 0.5) +
      geom_text(aes(label = scales::comma(n)), hjust = -0.2, fontface = "bold") +
      scale_x_continuous(expand = expansion(mult = c(0, 0.15))) +
      labs(title = "Bar Graph - Tail Behavior of Squirrel", 
           x = "Number of Squirrels", y = "Tail Bevavior") +
      theme_minimal() +
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        axis.title = element_text(face = "bold")   # makes both axis labels bold
      )
  })
  
  output$squirrel_plot4 <- renderPlot({ 
    central_park_tailbeh_obs %>%
      filter(did_tailbehavior == TRUE) %>%
      count(tailbehavior) %>%                                    # count per attitude
      mutate(pct = n / sum(n),                               # calculate proportion
             label = scales::percent(pct, accuracy = 1)) %>% # e.g. "45%"
      ggplot(aes(x = "", y = pct, fill = tailbehavior)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +                             # this turns bar into pie
      geom_text(aes(label = label),
                position = position_stack(vjust = 0.5),      # centers labels in slices
                color = "white", fontface = "bold", size = 5) +
      labs(title = "Pie Chart - Tail Behavior of Squirrel", fill = "Tail Behavior") +
      theme_void() +                                         # removes axes/gridlines
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        legend.title = element_text(face = "bold")
      )
  })
  
  output$squirrel_plot5 <- renderPlot({
    central_park_noise_obs %>%
      filter(made_noise == TRUE) %>%
      count(noise) %>%
      ggplot(aes(x = n, y = reorder(noise, n))) +
      geom_bar(stat = "identity", fill = "#652A0E", width = 0.5) +
      geom_text(aes(label = scales::comma(n)), hjust = -0.2, fontface = "bold") +
      scale_x_continuous(expand = expansion(mult = c(0, 0.15))) +
      labs(title = "Bar Graph - Squirrel Noise", 
           x = "Number of Squirrels", y = "Noise") +
      theme_minimal() +
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        axis.title = element_text(face = "bold") # makes both axis labels bold
      )
  })
  
  output$squirrel_plot6 <- renderPlot({
    central_park_noise_obs %>%
      filter(made_noise == TRUE) %>%
      count(noise) %>%
      mutate(pct = n / sum(n),                               # calculate proportion
             label = scales::percent(pct, accuracy = 1)) %>% # e.g. "45%"
      ggplot(aes(x = "", y = pct, fill = noise)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +                             # this turns bar into pie
      geom_text(aes(label = label),
                position = position_stack(vjust = 0.5),      # centers labels in slices
                color = "white", fontface = "bold", size = 5) +
      labs(title = "Pie Chart - Squirrel Noises", fill = "Noises") +
      theme_void() +                                         # removes axes/gridlines
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        legend.title = element_text(face = "bold")
      )
  })

  output$squirrel_plot7 <- renderPlot({
    central_park_act_obs %>%
      filter(did_activity == TRUE) %>%
      count(activity) %>%
      ggplot(aes(x = n, y = reorder(activity, n))) +
      geom_bar(stat = "identity", fill = "#652A0E", width = 0.5) +
      geom_text(aes(label = scales::comma(n)), hjust = -0.2, fontface = "bold") +
      scale_x_continuous(expand = expansion(mult = c(0, 0.15))) +
      labs(title = "Bar Graph - Squirrel Activity", 
           x = "Number of Squirrels", y = "Activity") +
      theme_minimal() +
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        axis.title = element_text(face = "bold") # makes both axis labels bold
      )
  })
  
  output$squirrel_plot8 <- renderPlot({
    central_park_act_obs %>%
      filter(did_activity == TRUE) %>%
      count(activity) %>%
      mutate(pct = n / sum(n),                               # calculate proportion
             label = scales::percent(pct, accuracy = 1)) %>% # e.g. "45%"
      ggplot(aes(x = "", y = pct, fill = activity)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +                             # this turns bar into pie
      geom_text(aes(label = label),
                position = position_stack(vjust = 0.5),      # centers labels in slices
                color = "white", fontface = "bold", size = 5) +
      labs(title = "Pie Chart - Squirrel Activity", fill = "Activity") +
      theme_void() +                                         # removes axes/gridlines
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        legend.title = element_text(face = "bold")
      )
  })  

  output$conditions_plot1 <- renderPlot({
    central_park_numeric_temp %>%
      group_by(proper_date_format, Shift) %>%
      summarise(avg_temp = mean(numeric_temp, na.rm = TRUE)) %>%
      ggplot(aes(proper_date_format, avg_temp, fill = Shift)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Average Daily Temperature In Central Park (AM vs PM)", 
           x = "Date", 
           y = "Average Temperature (°F)",
           fill = "Time of Day"
      ) +
      scale_fill_manual(values = c("AM" = "#5BA08A", "PM" = "#E09B6A")) +  # custom colors
      scale_x_date(
        breaks = unique(central_park_numeric_temp$proper_date_format),  # one break per date
        date_labels = "%b %d"                                           # formats as "Month Day"
      )   +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)           # angled so they don't overlap
            ) 
  })
}