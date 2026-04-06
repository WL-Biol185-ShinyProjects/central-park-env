library(shiny)
library(ggplot2)
library(tidyverse)
library(leaflet)
library(leaflet.extras)
library(ggwordcloud)
library(plotly)
library(tidyr)
library(dplyr, quietly = TRUE)

central_park <- read_csv("central_park_og.csv")
clean_temp <- read.csv("central_park_numeric_temp.csv")

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
humans_table <- central_park %>% select(X, Y, "Number of sighters") %>%
  rename(num_sighters = `Number of sighters`)

function(input, output, session) {
  
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
        axis.title = element_text(face = "bold")
      )
  })
  
  output$squirrel_plot2 <- renderPlot({
    central_park_attitude %>%
      filter(did_attitude == TRUE) %>%
      count(attitude) %>%
      mutate(pct = n / sum(n),
             label = scales::percent(pct, accuracy = 1)) %>%
      ggplot(aes(x = "", y = pct, fill = attitude)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +
      geom_text(aes(label = label),
                position = position_stack(vjust = 0.5),
                color = "white", fontface = "bold", size = 5) +
      labs(title = "Pie Chart - Squirrel Attitude when Approached by Human", fill = "Attitude") +
      theme_void() +
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
           x = "Number of Squirrels", y = "Tail Behavior") +
      theme_minimal() +
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        axis.title = element_text(face = "bold")
      )
  })
  
  output$juvenileCloud <- renderPlot({
    word_freq <- central_park_act_obs_age %>%
      filter(did_activity == TRUE) %>%
      filter(Age == "Juvenile") %>%
      count(activity, name = "n") %>%
      mutate(angle = 90 * sample(c(0,1), n(), replace = TRUE, prob = c(80, 20)))
    set.seed(42)
    ggplot(word_freq, aes(label = activity, size = n, angle = angle)) +
      geom_text_wordcloud(eccentricity = 20, grid_size = 40) +
      scale_size_area(max_size = 20) +
      theme_minimal()
  })
  
  output$adultCloud <- renderPlot({
    word_freq <- central_park_act_obs_age %>%
      filter(did_activity == TRUE) %>%
      filter(Age == "Adult") %>%
      count(activity, name = "n") %>%
      mutate(angle = 90 * sample(c(0,1), n(), replace = TRUE, prob = c(80, 20)))
    set.seed(35)
    ggplot(word_freq, aes(label = activity, size = n, angle = angle)) +
      geom_text_wordcloud(eccentricity = 20, grid_size = 40) +
      scale_size_area(max_size = 20) +
      theme_minimal()
  })
  
  output$squirrel_plot4 <- renderPlot({
    central_park_tailbeh_obs %>%
      filter(did_tailbehavior == TRUE) %>%
      count(tailbehavior) %>%
      mutate(pct = n / sum(n),
             label = scales::percent(pct, accuracy = 1)) %>%
      ggplot(aes(x = "", y = pct, fill = tailbehavior)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +
      geom_text(aes(label = label),
                position = position_stack(vjust = 0.5),
                color = "white", fontface = "bold", size = 5) +
      labs(title = "Pie Chart - Tail Behavior of Squirrel", fill = "Tail Behavior") +
      theme_void() +
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
        axis.title = element_text(face = "bold")
      )
  })
  
  output$squirrel_plot6 <- renderPlot({
    central_park_noise_obs %>%
      filter(made_noise == TRUE) %>%
      count(noise) %>%
      mutate(pct = n / sum(n),
             label = scales::percent(pct, accuracy = 1)) %>%
      ggplot(aes(x = "", y = pct, fill = noise)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +
      geom_text(aes(label = label),
                position = position_stack(vjust = 0.5),
                color = "white", fontface = "bold", size = 5) +
      labs(title = "Pie Chart - Squirrel Noises", fill = "Noises") +
      theme_void() +
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
        axis.title = element_text(face = "bold")
      )
  })
  
  output$squirrel_plot8 <- renderPlot({
    central_park_act_obs %>%
      filter(did_activity == TRUE) %>%
      count(activity) %>%
      mutate(pct = n / sum(n),
             label = scales::percent(pct, accuracy = 1)) %>%
      ggplot(aes(x = "", y = pct, fill = activity)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +
      geom_text(aes(label = label),
                position = position_stack(vjust = 0.5),
                color = "white", fontface = "bold", size = 5) +
      labs(title = "Pie Chart - Squirrel Activity", fill = "Activity") +
      theme_void() +
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
      geom_point(size = 3, color = "#5BA08A") +
      geom_line(color = "#5BA08A", linetype = "solid") +
      labs(title = "Average Daily Temperature In Central Park",
           x = "Date", y = "Average Temperature (°F)") +
      scale_y_continuous(limits = c(40, 80)) +
      scale_x_date(
        breaks = unique(central_park_numeric_temp$proper_date_format),
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
      labs(title = "Count of Days within Temperature Ranges - Daily Average",
           x = "Temperature (°F)", y = "Count of Days") +
      theme_minimal()
  })
  
  output$conditions_plot3 <- renderPlot({
    central_park_numeric_temp %>%
      group_by(proper_date_format, Shift) %>%
      summarise(avg_temp = mean(numeric_temp, na.rm = TRUE)) %>%
      ggplot(aes(proper_date_format, avg_temp, fill = Shift)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Average Daily Temperature In Central Park (AM vs PM)",
           x = "Date", y = "Average Temperature (°F)", fill = "Time of Day") +
      scale_fill_manual(values = c("AM" = "#5BA08A", "PM" = "#B87333")) +
      scale_x_date(
        breaks = unique(central_park_numeric_temp$proper_date_format),
        date_labels = "%b %d"
      ) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  output$conditions_plot4_5 <- renderPlot({
    if (input$shift_choice == "AM") {
      am_temp <- clean_temp %>%
        select(Date, Shift, numeric_temp) %>%
        mutate(Date = as.Date(as.character(Date), format = "%m%d%Y")) %>%
        group_by(Date, Shift) %>%
        summarise(numeric_temp = mean(numeric_temp, na.rm = TRUE), .groups = "drop") %>%
        filter(Shift == "AM")
      ggplot(am_temp, aes(x = numeric_temp)) +
        geom_histogram(breaks = seq(40, 75, by = 5), fill = "#8B4513", color = "white") +
        scale_x_continuous(breaks = seq(40, 75, by = 5), limits = c(40, 75)) +
        labs(title = "Count of Days within Temperature Ranges - AM",
             x = "Temperature (°F)", y = "Count of Days") +
        theme_minimal()
    } else {
      pm_temp <- clean_temp %>%
        select(Date, Shift, numeric_temp) %>%
        mutate(Date = as.Date(as.character(Date), format = "%m%d%Y")) %>%
        group_by(Date, Shift) %>%
        summarise(numeric_temp = mean(numeric_temp, na.rm = TRUE), .groups = "drop") %>%
        filter(Shift == "PM")
      ggplot(pm_temp, aes(x = numeric_temp)) +
        geom_histogram(breaks = seq(50, 80, by = 5), fill = "#8B4513", color = "white") +
        scale_x_continuous(breaks = seq(50, 80, by = 5), limits = c(50, 80)) +
        labs(title = "Count of Days within Temperature Ranges - PM",
             x = "Temperature (°F)", y = "Count of Days") +
        theme_minimal()
    }
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
      mutate(temp_range = cut(numeric_temp,
                              breaks = seq(30, 90, by = 5),
                              labels = c("30-35","35-40","40-45","45-50",
                                         "50-55","55-60","60-65","65-70",
                                         "70-75","75-80","80-85","85-90"),
                              include.lowest = TRUE)) %>%
      filter(!is.na(temp_range)) %>%
      count(temp_range, activity)
    ggplot(activity_temp, aes(x = temp_range, y = n, fill = activity)) +
      geom_bar(stat = "identity", position = "stack") +
      scale_fill_manual(values = c(
        "#A0522D", "#CD853F", "#DEB887", "#8B4513", "#D2691E"
      )) +
      labs(title = "Squirrel Activity by Temperature",
           subtitle = "Activities observed across temperature ranges in Central Park",
           x = "Temperature Range (°F)", y = "Number of Squirrels", fill = "Activity") +
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
           x = "Date", y = "Number of Squirrels", fill = "Fur Color") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  output$squirrel_map <- renderLeaflet({
    if (input$map_choice == "By Fur Color") {
      leaflet(data = fur) %>%
        setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
        addCircleMarkers(lng = ~X, lat = ~Y, radius = 3,
                         color = ~pal_fur(fur_color), fillOpacity = 0.7, stroke = FALSE) %>%
        addLegend(position = "bottomright", pal = pal_fur,
                  values = ~fur_color, title = "Squirrel Fur Color")
    } else if (input$map_choice == "By Litter Amount") {
      leaflet(data = litter) %>%
        setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
        addCircleMarkers(lng = ~X, lat = ~Y, radius = 3,
                         color = ~pal_litter(Litter), fillOpacity = 0.7, stroke = FALSE) %>%
        addLegend(position = "bottomright", pal = pal_litter,
                  values = ~Litter, title = "Litter Amount")
    } else if (input$map_choice == "By Age") {
      leaflet(data = age) %>%
        setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
        addCircleMarkers(lng = ~X, lat = ~Y, radius = 3,
                         color = ~pal_age(Age), fillOpacity = 0.7, stroke = FALSE) %>%
        addLegend(position = "bottomright", pal = pal_age,
                  values = ~Age, title = "Squirrel Age")
    } else if (input$map_choice == "Squirrel Density") {
      leaflet(data = central_park) %>%
        setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
        addCircleMarkers(lng = ~X, lat = ~Y, radius = 2.5,
                         color = "#8B4513", fillOpacity = 0.7, stroke = FALSE)
    } else if (input$map_choice == "Squirrel Heat Map") {
      leaflet(data = central_park) %>%
        setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
        addHeatmap(lng = ~X, lat = ~Y, blur = 25, max = 0.05, radius = 17) %>%
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
      leaflet(data = humans_table) %>%
        setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
        addCircleMarkers(lng = ~X, lat = ~Y, radius = ~num_sighters * 3,
                         color = "#8B4513", fillOpacity = 0.7, stroke = FALSE)
    }
  })
  
  output$squirrel_color_plot1 <- renderPlot({
    if (input$select_date == "All") {
      central_park_numeric_temp %>%
        filter(!is.na(Primary_Fur_Color)) %>%
        group_by(Primary_Fur_Color) %>%
        summarise(squirrel_count = n()) %>%
        ggplot(aes(Primary_Fur_Color, squirrel_count, fill = Primary_Fur_Color)) +
        geom_bar(stat = "identity", width = .5) +
        labs(title = "Squirrel Fur Color Count",
             x = "Fur Color", y = "Number of Squirrels") +
        scale_fill_manual(values = c("Black" = "black", "Gray" = "gray60",
                                     "Cinnamon" = "#B87333"),
                          na.value = "#4A7C59") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 0, hjust = 1), legend.position = "none")
    } else {
      central_park_numeric_temp %>%
        filter(proper_date_format == input$select_date) %>%
        filter(!is.na(Primary_Fur_Color)) %>%
        group_by(Primary_Fur_Color) %>%
        summarise(squirrel_count = n(), .groups = "drop") %>%
        ggplot(aes(Primary_Fur_Color, squirrel_count, fill = Primary_Fur_Color)) +
        geom_bar(stat = "identity", width = .5) +
        ylim(0, 300) +
        labs(title = paste("Squirrel Fur Color Count", input$select_date),
             x = "Fur Color", y = "Number of Squirrels") +
        scale_fill_manual(values = c("Black" = "black", "Gray" = "gray60",
                                     "Cinnamon" = "#B87333"),
                          na.value = "#4A7C59") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 0, hjust = 1), legend.position = "none")
    }
  })
  
  output$squirrel_color_plot2 <- renderPlot({
    central_park_numeric_temp %>%
      filter(!is.na(Primary_Fur_Color)) %>%
      group_by(Primary_Fur_Color) %>%
      summarise(squirrel_count = n()) %>%
      mutate(pct = squirrel_count / sum(squirrel_count),
             label = scales::percent(pct, accuracy = 1)) %>%
      ggplot(aes(x = "", y = squirrel_count, fill = Primary_Fur_Color)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar("y") +
      labs(title = "Squirrel Fur Color Count", fill = "Fur Color") +
      scale_fill_manual(values = c("Black" = "black", "Gray" = "gray60",
                                   "Cinnamon" = "#B87333"),
                        na.value = "#4A7C59") +
      theme_void() +
      theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 16))
  })
  
  # squirrel name generator
  output$quizUI <- renderUI({
    tagList(
      h3("What Type of Squirrel Are You?"),
      
      radioButtons("q1", "1. What is your ideal Saturday morning?",
                   choices = c("Sleeping in and having a big breakfast",
                               "Getting outside for a run",
                               "Exploring somewhere new",
                               "Staying cozy inside with a book")),
      
      radioButtons("q2", "2. What is your social style?",
                   choices = c("I love being around lots of people",
                               "I prefer a small close group of friends",
                               "I am a lone wolf",
                               "It depends on my mood")),
      
      radioButtons("q3", "3. How do you handle stress?",
                   choices = c("I run away from it",
                               "I face it head on",
                               "I distract myself with food",
                               "I climb to a higher perspective")),
      
      radioButtons("q4", "4. What is your favorite season?",
                   choices = c("Fall - cozy and full of snacks",
                               "Spring - fresh and full of energy",
                               "Summer - warm and adventurous",
                               "Winter - quiet and peaceful")),
      
      radioButtons("q5", "5. What is your ideal snack?",
                   choices = c("Nuts and seeds",
                               "Fruit and berries",
                               "Something warm and hearty",
                               "Whatever I can find")),
      
      radioButtons("q6", "6. How would your friends describe you?",
                   choices = c("Energetic and always on the move",
                               "Warm and nurturing",
                               "Mysterious and independent",
                               "Clever and resourceful")),
      
      radioButtons("q7", "7. What is your favorite place to hang out?",
                   choices = c("Up high with a great view",
                               "In a cozy hidden spot",
                               "Somewhere busy with lots going on",
                               "Out in an open field")),
      
      radioButtons("q8", "8. What do you do when you find something valuable?",
                   choices = c("Share it with others",
                               "Save it for later",
                               "Enjoy it right away",
                               "Hide it somewhere secret")),
      
      actionButton("submit_quiz", "Find Out My Squirrel Type!"),
      uiOutput("quiz_result")
    )
  })
  
  observeEvent(input$generate_name, {
    adjectives <- c("Fluffy", "Speedy", "Grumpy", "Sneaky", "Cheeky",
                    "Bouncy", "Crafty", "Nutty", "Zippy", "Scrappy",
                    "Sassy", "Jumpy", "Dizzy", "Wiggly", "Fuzzy")
    names <- c("Gerald", "Beatrice", "Chester", "Mildred", "Reginald",
               "Hazel", "Mortimer", "Agnes", "Cornelius", "Mabel",
               "Theodore", "Prudence", "Barnaby", "Edith", "Clifford")
    activities <- c("the Forager", "the Climber", "the Chaser",
                    "the Nut Hoarder", "the Tree Hugger",
                    "the Tail Twitcher", "the Speed Runner",
                    "the Indifferent", "the Brave", "the Sneaky")
    hectares <- c("of Hectare 1A", "of Hectare 3B", "of Hectare 5C",
                  "of the Great Lawn", "of Sheep Meadow",
                  "of the Ramble", "of Bethesda Fountain",
                  "of the North Woods", "of Cherry Hill",
                  "of Strawberry Fields")
    name <- paste(
      sample(adjectives, 1),
      sample(names, 1),
      sample(activities, 1),
      sample(hectares, 1)
    )
    output$squirrel_name <- renderText({ name })
  })

  
  


#buzzfeed quiz 

output$quizUI <- renderUI({
  tagList(
    h3("What Type of Squirrel Are You?"),
    
    radioButtons("q1", "1. What is your ideal Saturday morning?",
                 choices = c("Sleeping in and having a big breakfast",
                             "Getting outside for a run",
                             "Exploring somewhere new",
                             "Staying cozy inside with a book")),
                 selected = NULL  # no default selection
                                                                ,
    
    radioButtons("q2", "2. What is your social style?",
                 choices = c("I love being around lots of people",
                             "I prefer a small close group of friends",
                             "I am a lone wolf",
                             "It depends on my mood")),
                selected = character(0)  # no default selection,
                                                                ,
    radioButtons("q3", "3. How do you handle stress?",
                 choices = c("I run away from it",
                             "I face it head on",
                             "I distract myself with food",
                             "I climb to a higher perspective")),
                selected = character(0)  # no default selection,
                                                               ,
                                                          
    radioButtons("q4", "4. What is your favorite season?",
                 choices = c("Fall - cozy and full of snacks",
                             "Spring - fresh and full of energy",
                             "Summer - warm and adventurous",
                             "Winter - quiet and peaceful")),
                selected = character(0)  # no default selection,
                                                              ,
    
    radioButtons("q5", "5. What is your ideal snack?",
                 choices = c("Nuts and seeds",
                             "Fruit and berries",
                             "Something warm and hearty",
                             "Whatever I can find")),
                selected = character(0)  # no default selection,
                                                                ,
    
    radioButtons("q6", "6. How would your friends describe you?",
                 choices = c("Energetic and always on the move",
                             "Warm and nurturing",
                             "Mysterious and independent",
                             "Clever and resourceful")),
                 selected = character(0)  # no default selection,
                                                                ,
    
    radioButtons("q7", "7. What is your favorite place to hang out?",
                 choices = c("Up high with a great view",
                             "In a cozy hidden spot",
                             "Somewhere busy with lots going on",
                             "Out in an open field")),
                selected = character(0)  # no default selection,
                                                                ,
    radioButtons("q8", "8. What do you do when you find something valuable?",
                 choices = c("Share it with others",
                             "Save it for later",
                             "Enjoy it right away",
                             "Hide it somewhere secret")),
                selected = character(0)  # no default selection,
                                                                ,
    actionButton("submit_quiz", "Find Out My Squirrel Type!"),
    uiOutput("quiz_result")
  )
})

observeEvent(input$submit_quiz, {
  # check all questions are answered
  if (is.null(input$q1) || is.null(input$q2) || is.null(input$q3) ||
      is.null(input$q4) || is.null(input$q5) || is.null(input$q6) ||
      is.null(input$q7) || is.null(input$q8)) {
    showNotification("Please answer all questions before submitting!", 
                     type = "warning")
    return()
  }
  scores <- list(
    q1 = c("Sleeping in and having a big breakfast" = 2,
           "Getting outside for a run" = 3,
           "Exploring somewhere new" = 1,
           "Staying cozy inside with a book" = 2),
    q2 = c("I love being around lots of people" = 2,
           "I prefer a small close group of friends" = 1,
           "I am a lone wolf" = 3,
           "It depends on my mood" = 2),
    q3 = c("I run away from it" = 3,
           "I face it head on" = 2,
           "I distract myself with food" = 1,
           "I climb to a higher perspective" = 2),
    q4 = c("Fall - cozy and full of snacks" = 1,
           "Spring - fresh and full of energy" = 2,
           "Summer - warm and adventurous" = 3,
           "Winter - quiet and peaceful" = 2),
    q5 = c("Nuts and seeds" = 1,
           "Fruit and berries" = 2,
           "Something warm and hearty" = 2,
           "Whatever I can find" = 3),
    q6 = c("Energetic and always on the move" = 3,
           "Warm and nurturing" = 2,
           "Mysterious and independent" = 1,
           "Clever and resourceful" = 2),
    q7 = c("Up high with a great view" = 2,
           "In a cozy hidden spot" = 1,
           "Somewhere busy with lots going on" = 3,
           "Out in an open field" = 2),
    q8 = c("Share it with others" = 2,
           "Save it for later" = 1,
           "Enjoy it right away" = 3,
           "Hide it somewhere secret" = 2)
  )
  
  total <- scores$q1[input$q1] + scores$q2[input$q2] +
    scores$q3[input$q3] + scores$q4[input$q4] +
    scores$q5[input$q5] + scores$q6[input$q6] +
    scores$q7[input$q7] + scores$q8[input$q8]
  
  output$quiz_result <- renderUI({
    result <- if (total <= 10) {
      tagList(
        h2("You are a Black Squirrel!"),
        p("You are rare, mysterious, and independent. You march to the beat of
          your own drum and are not afraid to stand out from the crowd. Like the
          black squirrel, you are striking and unforgettable!")
      )
    } else if (total <= 14) {
      tagList(
        h2("You are a Cinnamon Squirrel!"),
        p("You are warm, adventurous, and full of energy. You bring a little spice
          to everything you do and love exploring new places. Like the cinnamon
          squirrel, you are vibrant and full of life!")
      )
    } else {
      tagList(
        h2("You are a Gray Squirrel!"),
        p("You are clever, resourceful, and adaptable. You thrive in any environment
          and are always prepared for what comes next. Like the gray squirrel, you
          are a true survivor and the backbone of your community!")
      )
    }
    result
  })
})
}