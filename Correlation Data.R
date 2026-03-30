output$correlation_plot <- renderPlot({
  central_park_numeric_temp %>%
    filter(!is.na(Number.of.sighters), !is.na(Total.Time.of.Sighting)) %>% 
    
    # as.factor() tells R to treat the number of sighters as distinct groups
    ggplot(aes(x = as.factor(Number.of.sighters), y = Total.Time.of.Sighting)) +
    geom_boxplot(fill = "#DEB887", color = "#8B4513") +  
    
    labs(
      title = "Sighting Duration by Number of Observers",
      x = "Number of Sighters",
      y = "Total Time of Sighting (Minutes)" 
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
      axis.title = element_text(face = "bold")
    )
})

output$correlation_plot <- renderPlot({
  
  central_park_numeric_temp %>%
    # Filter for your specific columns
    filter(!is.na(numeric_temp), !is.na(Number.of.Squirrels)) %>% 
    
    ggplot(aes(x = numeric_temp, y = Number.of.Squirrels)) +
    # geom_jitter separates the dots so they don't hide behind each other
    geom_jitter(color = "#8B4513", alpha = 0.4, width = 1, height = 0.2) +  
    
    # Fits a linear regression model to show the overall statistical trend
    geom_smooth(method = "lm", color = "#5BA08A", se = TRUE) + 
    
    labs(
      title = "Correlation: Temperature vs. Number of Squirrels",
      x = "Temperature (°F)",
      y = "Number of Squirrels per Sighting" 
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
      axis.title = element_text(face = "bold")
    )
})

