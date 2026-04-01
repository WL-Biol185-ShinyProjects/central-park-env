
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




#plotly with count of squirrels vs day

        
squirrel_count <- central_park_numeric_temp %>%
      group_by(proper_date_format) %>%
      summarise(squirrel_count = n()) %>%

  
  library(dplyr)
library(ggplot2)

squirrel_count <- central_park_numeric_temp %>%
  group_by(proper_date_format) %>%
  summarise(squirrel_count = n())

central_park_numeric_temp
ggplot(squirrel_count, aes(proper_date_format, squirrel_count)) +
  geom_bar(stat = "identity", fill = "#652A0E") +
  labs(
    title = "Squirrel Stats Per Day",
    x = "Date",
    y = "Number of Squirrels"
  ) +
  theme_minimal()

#summary table for plotly (working)
squirrel_summary <- central_park_numeric_temp %>%
  select(proper_date_format, numeric_temp, Running, Chasing, Climbing, Eating, Foraging, Kuks, Quaas, Moans, Total_Time_of_Sighting) %>% 
      pivot_longer(
          cols = c(Running, Chasing, Climbing, Eating, Foraging),
          names_to = "activity",
          values_to = "did_activity"
  ) %>%
    filter(did_activity == TRUE, !is.na(proper_date_format)) %>%
    group_by(proper_date_format, activity) %>%
    summarise(
      count = n(),
      most_common_noise = names(sort(table(c(
        rep("Kuks", sum(Kuks, na.rm = TRUE)),
        rep("Quaas", sum(Quaas, na.rm = TRUE)),
        rep("Moans", sum(Moans, na.rm = TRUE))
      )), decreasing = TRUE))[1],
      avg_sighting_time = round(mean(Total_Time_of_Sighting, na.rm = TRUE), 1)
    ) %>%
    slice_max(count, n = 1) %>%
    rename(most_common_activity = activity) %>%
    select(proper_date_format, most_common_activity, most_common_noise, avg_sighting_time))
  
  
  
  
  
  group_by(proper_date_format) %>%
  summarise(
    squirrel_count = n(),
    avg_temp = mean(numeric_temp, na.rm = TRUE),
    most_common_activity = ()
    
#Here is what Claude said after I worked back and forth with it for some time but had to stop... still need to edit and get rid of emohi stuff :(
library(dplyr)
library(plotly)
library(tidyr)

# Step 1: Most common activity per day
activity_summary <- central_park_numeric_temp %>%
  select(proper_date_format, Running, Chasing, Climbing, Eating, Foraging) %>%
  pivot_longer(
    cols = c(Running, Chasing, Climbing, Eating, Foraging),
    names_to = "activity",
    values_to = "did_activity"
  ) %>%
  filter(did_activity == TRUE, !is.na(proper_date_format)) %>%
  group_by(proper_date_format, activity) %>%
  summarise(count = n(), .groups = "drop") %>%
  slice_max(count, n = 1, by = proper_date_format) %>%
  select(proper_date_format, most_common_activity = activity)

# Step 2: Most common noise per day
noise_summary <- central_park_numeric_temp %>%
  select(proper_date_format, Kuks, Quaas, Moans) %>%
  pivot_longer(
    cols = c(Kuks, Quaas, Moans),
    names_to = "noise",
    values_to = "made_noise"
  ) %>%
  filter(made_noise == TRUE, !is.na(proper_date_format)) %>%
  group_by(proper_date_format, noise) %>%
  summarise(count = n(), .groups = "drop") %>%
  slice_max(count, n = 1, by = proper_date_format) %>%
  select(proper_date_format, most_common_noise = noise)

# Step 3: Main summary table
squirrel_summary <- central_park_numeric_temp %>%
  group_by(proper_date_format) %>%
  summarise(
    squirrel_count = n(),
    avg_temp = round(mean(numeric_temp, na.rm = TRUE), 1),
    avg_sighting_time = round(mean(Total_Time_of_Sighting, na.rm = TRUE), 1),
    most_common_fur = names(sort(table(Primary.Fur.Color), decreasing = TRUE))[1],
    .groups = "drop"
  ) %>%
  arrange(proper_date_format) %>%
  left_join(activity_summary, by = "proper_date_format") %>%
  left_join(noise_summary, by = "proper_date_format")

# Step 4: Build hover text as vertical list
squirrel_summary <- squirrel_summary %>%
  mutate(hover_text = paste0(
    "<b>Date: ", proper_date_format, "</b><br>",
    "─────────────────<br>",
    "🐿️ Squirrels: ", squirrel_count, "<br>",
    "🌡️ Avg Temp: ", avg_temp, "°F<br>",
    "⏱️ Avg Sighting Time: ", avg_sighting_time, " sec<br>",
    "🎨 Most Common Fur: ", most_common_fur, "<br>",
    "🏃 Most Common Activity: ", most_common_activity, "<br>",
    "🔊 Most Common Noise: ", most_common_noise
  ))

# Step 5: Plot
plot_ly(
  squirrel_summary,
  x = ~proper_date_format,
  y = ~squirrel_count,
  type = "bar",
  marker = list(color = "brown"),
  text = ~hover_text,
  hoverinfo = "text"
) %>%
  layout(
    title = "Squirrel Entries per Day - Central Park Census",
    xaxis = list(title = "Date"),
    yaxis = list(title = "Number of Squirrels"),
    hoverlabel = list(
      bgcolor = "white",
      font = list(size = 13)
    )
  )
```

When you hover over each bar it will show a clean vertical list like:
  ```
Date: 2018-10-06
─────────────────
🐿️ Squirrels: 342
🌡️ Avg Temp: 65.2°F
⏱️ Avg Sighting Time: 11.4 sec
🎨 Most Common Fur: Gray
🏃 Most Common Activity: Foraging
🔊 Most Common Noise: Kuks
   
   
   