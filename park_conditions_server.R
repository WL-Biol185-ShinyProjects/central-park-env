library(shiny)
library(ggplot2)
library(tidyverse)



central_park_numeric_temp %>%
  ggplot(aes(Date, numeric_temp)) +
  geom_boxplot()