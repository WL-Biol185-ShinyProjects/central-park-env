library(shiny)
library(ggplot2)
library(tidyverse)
library(leaflet)
library(leaflet.extras)
library(ggwordcloud)
library(plotly)
library(dplyr, quietly = TRUE)

central_park <- read_csv("central_park_og.csv")

source("Compiled_Observation_Tables.R")
source("park_conditions_data_organization_file.R")
source("map_generation.R")



# DATA PREP FOR MAP GENERATION

# age map
age_table <- central_park %>% select(X, Y, Age)
age_table[age_table == "?"] <- NA
age <- age_table %>% drop_na()

pal_age <- colorFactor(
  palette = c("#FFD700", "#FF4500"),
  levels = c("Adult", "Juvenile")
)

# fur map
fur_table <- central_park %>% select(X, Y, "Primary Fur Color")
fur <- fur_table %>% drop_na()
fur <- fur %>% rename(fur_color = `Primary Fur Color`)

pal_fur <- colorFactor(
  palette = c("#696969", "#FF6B00", "#000000"),
  levels = c("Gray", "Cinnamon", "Black")
)

# litter map
litter_table <- central_park %>% select(X, Y, Litter)
litter <- litter_table %>% drop_na()

pal_litter <- colorFactor(
  palette = c("#00CC00", "#FFD700", "#FF0000"),
  levels = c("None", "Some", "Abundant")
)

# human map
humans_table <- central_park %>% select(X, Y, "Number of sighters") %>% rename(num_sighters = `Number of sighters`)

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
  
  # creation of frequency table filtered to TRUE and consolidating to young
  output$juvenileCloud <- renderPlot({ 
    word_freq <- central_park_act_obs_age %>%
      filter(did_activity == TRUE) %>%
      filter(Age == "Juvenile") %>%
      count(activity, name = "n") %>%
      mutate(angle = 90 * sample(c(0,1),n(), replace = TRUE, prob = c(80, 20)))
    
    set.seed(42)
    ggplot(word_freq, aes(label = activity, size = n, angle = angle)) +
      geom_text_wordcloud(eccentricity = 20, grid_size = 40) +
      scale_size_area(max_size = 20) +
      theme_minimal()
    
  })
  
  
  # creation of frequency table filtered to TRUE and consolidating to adult
  output$adultCloud <- renderPlot({ 
    word_freq <- central_park_act_obs_age %>%
      filter(did_activity == TRUE) %>%
      filter(Age == "Adult") %>%
      count(activity, name = "n") %>%
      mutate(angle = 90 * sample(c(0,1),n(), replace = TRUE, prob = c(80, 20)))
    
    set.seed(35)
    ggplot(word_freq, aes(label = activity, size = n, angle = angle)) +
      geom_text_wordcloud(eccentricity = 20, grid_size = 40) +
      scale_size_area(max_size = 20) +
      theme_minimal()
    
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
      group_by(proper_date_format) %>%
      summarise(avg_temp = mean(numeric_temp, na.rm = TRUE), .groups = "drop") %>%
      ggplot(aes(proper_date_format, avg_temp)) +
      geom_point(size = 3, color = "#5BA08A") +                  # points
      geom_line(color = "#5BA08A", linetype = "solid") +        # optional: connects the dots
      labs(title = "Average Daily Temperature In Central Park", 
           x = "Date", 
           y = "Average Temperature (°F)") +
      scale_y_continuous(limits = c(40, 80)) +   
      scale_x_date(
        breaks      = unique(central_park_numeric_temp$proper_date_format),
        date_labels = "%b %d"
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  output$conditions_plot2 <- renderPlot({
    days_in_temp <- clean_temp %>%
      select(Date, numeric_temp) %>%
      mutate(Date = as.Date(as.character(Date), format = "%m%d%Y")) %>%
      group_by(Date) %>%
      summarise(numeric_temp = mean(numeric_temp, na.rm = TRUE), .groups = "drop")
    
    ggplot(days_in_temp, aes(x = numeric_temp)) +
      geom_histogram(breaks = seq(50, 80, by = 5), fill = "#8B4513", color = "white") +
      scale_x_continuous(breaks = seq(50, 80, by = 5), limits = c(50, 80)) +
      labs(
        title = "Count of Days within Temperature Ranges - Daily Average",
        x = "Temperature (°F)",
        y = "Count of Days"
      ) +
      theme_minimal()
    
  })
  
  output$conditions_plot3 <- renderPlot({
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
      scale_fill_manual(values = c("AM" = "#5BA08A", "PM" = "#B87333")) +  # custom colors
      scale_x_date(
        breaks = unique(central_park_numeric_temp$proper_date_format),  # one break per date
        date_labels = "%b %d"                                           # formats as "Month Day"
      )   +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)           # angled so they don't overlap
      ) 
  })

  output$conditions_plot4 <- renderPlot({
    am_temp <- clean_temp %>%
      select(Date, Shift, numeric_temp) %>%
      mutate(Date = as.Date(as.character(Date), format = "%m%d%Y")) %>%
      group_by(Date, Shift) %>%
      summarise(numeric_temp = mean(numeric_temp, na.rm = TRUE), .groups = "drop") %>%
      filter(Shift == "AM")
    
    ggplot(am_temp, aes(x = numeric_temp)) +
      geom_histogram(breaks = seq(40, 75, by = 5), fill = "#8B4513", color = "white") +
      scale_x_continuous(breaks = seq(40, 75, by = 5), limits = c(40, 75)) +
      labs(
        title = "Count of Days within Temperature Ranges - AM",
        x = "Temperature (°F)",
        y = "Count of Days"
      ) +
      theme_minimal()
  })
  
  output$temp_activity_plot <- renderPlot({
    activity_temp <- central_park_numeric_temp %>%
      select(numeric_temp, Running, Chasing, Climbing, Eating, Foraging) %>%
      pivot_longer(
        cols = c(Running, Chasing, Climbing, Eating, Foraging),
        names_to = "activity",
        values_to = "did_activity"
      ) %>%
      filter(did_activity == TRUE, !is.na(numeric_temp)) %>%
      mutate(temp_range = cut(numeric_temp,        # ← groups temps into ranges
                              breaks = seq(30, 90, by = 5),
                              labels = c("30-35","35-40","40-45","45-50",
                                         "50-55","55-60","60-65","65-70",
                                         "70-75","75-80","80-85","85-90"),
                              include.lowest = TRUE)) %>%
      count(temp_range, activity)                  # ← count per group
    
    ggplot(activity_temp, aes(x = temp_range, y = n, fill = activity)) +
      geom_bar(stat = "identity", position = "stack") +  # ← stacked
      scale_fill_manual(values = c(
        "#A0522D", "#CD853F", "#DEB887", "#8B4513", "#D2691E"
      )) +
      labs(
        title = "Squirrel Activity by Temperature",
        subtitle = "Activities observed across temperature ranges in Central Park",
        x = "Temperature Range (°F)",
        y = "Number of Squirrels",
        fill = "Activity"
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        plot.subtitle = element_text(hjust = 0.5, color = "grey50"),
        axis.title = element_text(face = "bold"),
        axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "bottom"
      )
  })
  
  output$color_plot1 <- renderPlot({
    central_park_numeric_temp %>%
      group_by(proper_date_format, Primary_Fur_Color) %>%
      summarise(count = n(), .groups = "drop") %>%
      mutate(proper_date_format = factor(format(proper_date_format, "%b %d"))) %>%
      ggplot(aes(x = proper_date_format, y = count, fill = Primary_Fur_Color)) +
      geom_bar(stat = "identity", position = "stack") +
      labs(title = "Squirrel Fur Color Count by Day",
           x = "Date", y = "Number of Squirrels",
           fill = "Fur Color") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)
      )
  })
  
  output$squirrel_map <- renderLeaflet({
    
    if (input$map_choice == "By Fur Color") {
      leaflet(data = fur) %>%
        setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
        addCircleMarkers(
          lng = ~X, lat = ~Y, radius = 3,
          color = ~pal_fur(fur_color),
          fillOpacity = 0.7, stroke = FALSE
        ) %>%
        addLegend(position = "bottomright", pal = pal_fur,
                  values = ~fur_color, title = "Squirrel Fur Color")
      
    } else if (input$map_choice == "By Litter Amount") {
      leaflet(data = litter) %>%
        setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
        addCircleMarkers(
          lng = ~X, lat = ~Y, radius = 3,
          color = ~pal_litter(Litter),
          fillOpacity = 0.7, stroke = FALSE
        ) %>%
        addLegend(position = "bottomright", pal = pal_litter,
                  values = ~Litter, title = "Litter Amount")
      
    } else if (input$map_choice == "By Age") {
      leaflet(data = age) %>%
        setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
        addCircleMarkers(
          lng = ~X, lat = ~Y, radius = 3,
          color = ~pal_age(Age),
          fillOpacity = 0.7, stroke = FALSE
        ) %>%
        addLegend(position = "bottomright", pal = pal_age,
                  values = ~Age, title = "Squirrel Age")
      
    } else if (input$map_choice == "Squirrel Density") {
      leaflet(data = central_park)%>% 
        setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>% 
        addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
        addCircleMarkers(
          lng = ~X,
          lat = ~Y,
          radius = 2.5,
          color = "#8B4513",
          fillOpacity = 0.7,
          stroke = FALSE
        )
      
    } else if (input$map_choice == "Squirrel Heat Map") {
      leaflet(data = central_park) %>%
        setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap) %>%  
        addHeatmap(
          lng = ~X,
          lat = ~Y,
          blur = 25,      # how smooth/spread out the heat is
          max = 0.05,     # intensity ceiling
          radius = 17    # size of each point's influence
        ) %>%
        addControl(
          html = '
      <div style="background:white; padding:8px; border-radius:5px;">
        <b>Squirrel Density</b><br>
        <span style="color:#0000FF;">&#9632;</span> Low<br>
        <span style="color:#00FF00;">&#9632;</span> Medium<br>
        <span style="color:#FF0000;">&#9632;</span> High
      </div>',
          position = "bottomright"
        )
    } else if (input$map_choice == "Human Density") {
      leaflet(data = humans_table)%>% 
        setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>% 
        addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
        addCircleMarkers(
          lng = ~X,
          lat = ~Y,
          radius = ~num_sighters * 3,
          color = "#8B4513",
          fillOpacity = 0.7,
          stroke = FALSE
        )
      
    }
    
  })
  

  output$squirrel_color_plot1 <- renderPlot({
    print(input$select_date=="All")
    if (input$select_date == "All") {
      central_park_numeric_temp %>%
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
          na.value   = "#4A7C59"       # catches actual NA values
        ) +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 0, hjust = 1), legend.position = "none")  
    } else {
      central_park_numeric_temp %>%
      filter(proper_date_format == input$select_date) %>%      # filter by selected date
        group_by(Primary_Fur_Color) %>%
        summarise(squirrel_count = n(), .groups = "drop") %>%
        ggplot(aes(Primary_Fur_Color, squirrel_count, fill = Primary_Fur_Color)) +
        geom_bar(stat = "identity", width = .5) +
        ylim(0,300) + 
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
  })
  
  output$squirrel_color_plot2 <- renderPlot({
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
     theme_void() +                                                        
     theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 16))
  })
  
}

