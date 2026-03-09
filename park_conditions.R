library(tidyverse)
library(shiny)

park_conditions <- fluidRow(
                      box(plotOutput("plot1", height = 250)),
                      
                      box()
)