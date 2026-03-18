library (shiny)

where_are_they <- tabItem(tabName = "where_are_they",
                          fluidPage(
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("map_choice",
                                            label = "Squirrels in Central Park",
                                            choices = c("Density", "Heat Map", "By Fur Color", "By Litter Amount", "By Age"))
                              ),
                              mainPanel(
                                leafletOutput("squirrel_map")
                              )
                            )
                          )
)