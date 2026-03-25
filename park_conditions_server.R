library(shiny)
library(ggplot2)
library(tidyverse)

central_park_numeric_temp %>%
  ggplot(aes(Date, numeric_temp)) +
  geom_boxplot()

output$temp_activity_plot <- renderPlot({
  activity_temp <- central_park_numeric_temp %>%
    select(numeric_temp, Running, Chasing, Climbing, Eating, Foraging) %>%
    pivot_longer(
      cols = c(Running, Chasing, Climbing, Eating, Foraging),
      names_to = "activity",
      values_to = "did_activity"
    ) %>%
    filter(did_activity == TRUE, !is.na(numeric_temp))
  
  central_park_numeric_temp %>%
    ggplot(aes(Date, numeric_temp)) +
    geom_boxplot()
})