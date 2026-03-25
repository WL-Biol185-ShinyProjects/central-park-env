library (shiny)

where_are_they <- tabItem(tabName = "where_are_they",
                          fluidRow(
                            box(
                              width = 2,
                              height = "400px",
                              title = "Squirrels in Central Park",
                              selectInput("map_choice",
                                          label = "Select Map Type",
                                          choices = c("Squirrel Density", "Squirrel Heat Map", "Human Density", "By Fur Color", "By Litter Amount", "By Age"))
                            ),
                            box(
                              width = 10,
                              height = "800px",
                              leafletOutput("squirrel_map", height = "800px")
                            )
                          )
)