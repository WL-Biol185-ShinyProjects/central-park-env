library(tidyverse)
library(ggplot2)


  central_park_numeric_temp %>%
  group_by(proper_date_format, Shift) %>%
    summarise(avg_temp = mean(numeric_temp, na.rm = TRUE)) %>%
    ggplot(aes(proper_date_format, avg_temp, fill = Shift)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(title = "Daily Average Temperature In Central Park (AM vs PM)", 
         x = "Date", 
         y = "Average Temperature (°F)",
         fill = "Time of Day"
    ) +
  scale_fill_manual(values = c("AM" = "#5BA08A", "PM" = "#E09B6A")) +  # custom colors
    scale_x_date(
      breaks = unique(central_park_numeric_temp$proper_date_format),  # one break per date
      date_labels = "%b %d"                                           # formats as "Month Day"
  )   +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) # angled so they don't overlap

 
