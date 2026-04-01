library(shiny)
library(tidyverse)
library(lubridate)
library(shinydashboard)

central_park_numeric_temp <- read_csv("central_park_numeric_temp.csv")
source("Compiled_Observation_Tables.R")
source("park_conditions_data_organization_file.R")

meet_the_squirrels <- tabItem(tabName = "meet_the_squirrels",
                              
                              # fun facts ticker
                              tags$div(
                                style = "background: #A0522D; color: white; padding: 10px; overflow: hidden; white-space: nowrap; margin-bottom: 15px;",
                                tags$div(
                                  style = "display: inline-block; animation: ticker 40s linear infinite;",
                                  "Squirrel Fun Facts: 🐿 Squirrels can locate food buried under a foot of snow! ⬥  🐿️ A squirrel's front teeth never stop growing! ⬥  🐿️ Humans introduced squirrels to most of our major city parks. ⬥  🐿️ A newborn squirrel is about an inch long. ⬥  🐿️ Squirrels may pretend to bury a nut to throw off potential thieves. ⬥  🐿️ Every time a squirrel doesn't retrieve one of their buried nuts, it plants trees!"
                                )
                              ),
                              
                              fluidRow(
                                box(
                                  width = 12,
                                  div(
                                    style = "width: 100%; height: 400px; overflow: hidden;",
                                    tags$img(
                                      src = "https://media.istockphoto.com/id/1667398983/photo/squirrel-in-central-park-new-york-city.jpg?s=612x612&w=0&k=20&c=uz0a7GzAq5CbfBlEQcAelOqtRig0pHmrpUBsWHTifRE=",
                                      style = "width: 100%; height: 100%; object-fit: contain;"
                                    )
                                  )
                                )
                              ),
                              fluidRow(
                                box(
                                  title = "About the Squirrels", width = 12,
                                  p("This app focuses on an open access data set compiled by the 2018 squirrel census available through NYC open data. This data set was collected through 323 volunteer squirrel sighters in October of 2018 and findings regarding the population size of a particular grey squirrel species (sciurus carolinensis) within Central Park. However, there is so much more to the Central Park squirrel community than just the number of eastern grey squirrels present, and it is those dynamics that you can see here!")
                                )
                              ),
                              fluidRow(
                                box(
                                  title = "Central Park Squirrels", width = 6,
                                  p("It is expected that over 2000 Eastern grey squirrels call central park home. Since their introduction to the park in the 1870's they have become treasured icons among the park's residents. These city squirrels are primarily grey with some variations being black and cinnamon which will be reflected in the data. While park visitors are now discouraged from feeding the squirrels they remain fairly comfortable around them allowing for excellent observation within the park.")
                                ),
                                box(
                                  title = "What to Expect", width = 6,
                                  p("On this site you will find a variety of data concerning eastern grey squirrels from observations of their behavior, where they are and what the weather was like at the time of their sighting. This site then takes that data a step further bringing different elements together to tell a full story for squirrels in central park.")
                                )
                              ),
                              fluidRow(
                                box(width = 6, plotOutput("squirrel_color_plot2")),
                                box(width = 6, plotOutput("squirrel_color_plot1"))
                              ),
                              fluidRow(
                                box(
                                  width = 9,
                                  p("The graphs displayed here depict the primary fur colors of squirrels recorded by observers throughout the 2018 Central Park Squirrel Census. The pie chart provides a high level overview of the proportional breakdown of fur colors across all squirrels surveyed during the census period, giving a quick visual sense of which colors dominate the population. This same data is then explored in greater detail through the bar graph seen on the right, which breaks down fur color counts by individual survey day. By filtering through specific dates, we can begin to observe how the composition of squirrel fur colors shifts across the census period, offering a closer look into the diversity and distribution of the squirrel population within Central Park.")
                                ),
                                box(
                                  width = 3,
                                  selectInput("select_date", "Select Date:",
                                              choices = c("All", as.character(sort(unique(central_park_numeric_temp$proper_date_format))), recursive = TRUE),
                                              selected = "All")
                                )
                              )
)
