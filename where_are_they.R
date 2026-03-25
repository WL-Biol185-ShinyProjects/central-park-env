library (shiny)

where_are_they <- tabItem(tabName = "where_are_they",
                          fluidRow(
                            box(
                              width = 12,
                              title = "Squirrels in Central Park",
                              selectInput("map_choice",
                                          label = "Select Map",
                                          choices = c("Squirrel Density", "Squirrel Heat Map", "Human Density", "By Fur Color", "By Litter Amount", "By Age"))
                            )
                          ),
                          fluidRow(
                            box(
                              width = 12,
                              height = "800px",
                              tags$head(tags$style(HTML("
      .box-body {
        padding-top: 40px !important;
      }
    "))),
                              leafletOutput("squirrel_map", height = "580px")
                            )
                          )
)