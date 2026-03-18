library(shiny)
library(ggplot2)
library(tidyverse)
library(leaflet)
library(leaflet.extras)

central_park <- read_csv("central_park_og.csv")

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
    
  } else if (input$map_choice == "Density") {
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
    
  } else if (input$map_choice == "Heat Map") {
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
  }
    
})
  
}

