library(tidyverse)
library(ggplot2)

#conditions plot 1
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
  scale_fill_manual(values = c("AM" = "#5BA08A", "PM" =  "#8B4513")) +  # custom colors
    scale_x_date(
      breaks = unique(central_park_numeric_temp$proper_date_format),  # one break per date
      date_labels = "%b %d"                                           # formats as "Month Day"
  )   +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) # angled so they don't overlap
  
  
  #conditions plot 2
  central_park_numeric_temp %>%
    group_by(proper_date_format) %>%
    summarise(avg_temp = mean(numeric_temp, na.rm = TRUE), .groups = "drop") %>%
    ggplot(aes(proper_date_format, avg_temp)) +
    geom_point(size = 3, color = "#5BA08A") +                  # points
    geom_line(color = "#5BA08A", linetype = "solid") +        # optional: connects the dots
    labs(title = "Daily Average Temperature In Central Park", 
         x = "Date", 
         y = "Average Temperature (°F)") +
    scale_y_continuous(limits = c(0, NA)) +   
    scale_x_date(
      breaks      = unique(central_park_numeric_temp$proper_date_format),
      date_labels = "%b %d"
    ) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

  
#in the works
  central_park_numeric_temp %>%
    ggplot(aes(Hectare_Conditions, Number_of_Squirrels)) + geom_bar(stat= "identity")
  
#squirrel color per day 
  central_park_numeric_temp %>%
    group_by(proper_date_format, Primary_Fur_Color) %>%
    summarise(squirrel_count = n()) %>%
    ggplot(aes(proper_date_format, squirrel_count, fill = Primary_Fur_Color)) +
    geom_bar(stat = "identity", position = "stack") +
    labs(title = "Squirrel Fur Color Count",
         x = "Date",
         y = "Number of Squirrels",
         fill = "Fur Color") +
    scale_fill_manual(values = c(
        "Black"    = "black",
        "Gray"     = "gray60",
        "Cinnamon"    = "#B87333",
        "NA"       = "#4A7C59"  
                                ),
          na.value = "#4A7C59"       # catches actual NA values
    ) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  
  
  #squirrel color pie chart
  central_park_numeric_temp %>%
    group_by(Primary_Fur_Color) %>%
    summarise(squirrel_count = n()) %>%
    mutate(
      pct   = squirrel_count / sum(squirrel_count),
      label = scales::percent(pct, accuracy = 1)) %>%
    ggplot(aes(x="", y=squirrel_count, fill=Primary_Fur_Color)) +
    geom_bar(stat = "identity", width = 1) +
    coord_polar("y") +
    labs(title = "Squirrel Fur Color Count", fill = "Fur Color") +
    scale_fill_manual(values = c(
      "Black"    = "black",
      "Gray"     = "gray60",
      "Cinnamon" = "#B87333",
      "NA"       = "#4A7C59"),
      na.value   = "#4A7C59") +
    theme_void() +                                                        # fix 3: void removes axes
    theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 16))

  #squirrel color count total 
  #choices
  central_park_numeric_temp %>%
      if(input$select_date==all) {
        group_by(Primary_Fur_Color) %>%
          summarise(squirrel_count = n()) %>%
          ggplot(aes(Primary_Fur_Color, squirrel_count, fill=Primary_Fur_Color)) +
          geom_bar(stat = "identity", width=.5) +
          labs(title = "Squirrel Fur Color Count",
               x = "Fur Color",
               y = "Number of Squirrels",) +
          scale_fill_manual(values = c(
            "Black"    = "black",
            "Gray"     = "gray60",
            "Cinnamon" = "#B87333",
            "NA"       = "#4A7C59"),
             na.value = "#4A7C59"       # catches actual NA values
          ) +
          theme_minimal() +
          theme(axis.text.x = element_text(angle = 0, hjust = 1), legend.position = "none")  
      } else {
          filter(proper_date_format == input$select_date) %>%      # filter by selected date
          group_by(Primary_Fur_Color) %>%
          summarise(squirrel_count = n(), .groups = "drop") %>%
          ggplot(aes(Primary_Fur_Color, squirrel_count, fill = Primary_Fur_Color)) +
          geom_bar(stat = "identity", width = .5) +
          labs(title = paste("Squirrel Fur Color Count", input$select_date),
               x = "Fur Color",
               y = "Number of Squirrels") +
          scale_fill_manual(values = c(
            "Black"    = "black",
            "Gray"     = "gray60",
            "Cinnamon" = "#B87333",
            "NA"       = "#4A7C59"),
            na.value   = "#4A7C59") +
          theme_minimal() +
          theme(axis.text.x = element_text(angle = 0, hjust = 1), legend.position = "none")
        }
    
  
  
  #bad
    group_by(Primary_Fur_Color) %>%
    summarise(squirrel_count = n()) %>%
    ggplot(aes(Primary_Fur_Color, squirrel_count, fill=Primary_Fur_Color)) +
    geom_bar(stat = "identity", width=.5) +
    labs(title = "Squirrel Fur Color Count",
         x = "Fur Color",
         y = "Number of Squirrels",) +
    scale_fill_manual(values = c(
      "Black"    = "black",
      "Gray"     = "gray60",
      "Cinnamon"    = "#B87333",
      "NA"       = "#4A7C59"  
    ),
    na.value = "#4A7C59"       # catches actual NA values
    ) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 0, hjust = 1), legend.position = "none")  
    
    
    library(plotly)
    
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
  