
#plotly from claude with some other things added in that would go in server

output$floating_plot1 <- renderPlotly({
  plot_data <- central_park_numeric_temp %>%
    group_by(proper_date_format) %>%
    summarise(
      avg_temp          = mean(numeric_temp, na.rm = TRUE),
      total_sighters    = sum(Number_of_sighters, na.rm = TRUE),       # total human sighters per day
      total_squirrels   = sum(Number_of_Squirrels, na.rm = TRUE),      # total squirrels per day
      .groups = "drop"
    )
  
  p <- plot_data %>%
    ggplot(aes(x = proper_date_format, y = avg_temp,
               text = paste0(
                 "Date: ",             format(proper_date_format, "%b %d"), "\n",
                 "Avg Temp: ",         round(avg_temp, 1), "°F\n",
                 "Squirrels Sighted: ", total_squirrels, "\n",
                 "Human Sighters: ",   total_sighters
               ))) +
    geom_point(size = 3, color = "#5BA08A") +
    geom_line(color = "#5BA08A", linetype = "solid") +
    labs(title = "Daily Average Temperature In Central Park",
         x = "Date",
         y = "Average Temperature (°F)") +
    scale_y_continuous(limits = c(40, 80)) +
    scale_x_date(
      breaks      = unique(plot_data$proper_date_format),
      date_labels = "%b %d"
    ) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  ggplotly(p, tooltip = "text")
})