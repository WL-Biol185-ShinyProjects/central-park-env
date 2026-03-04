library(shiny)


dashboardPage(
  dashboardHeader(title = "Squirrel Exploration in NYC"),
  dashboardSidebar(title = "What's the squirrel doing?"),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(plotOutput("plot1", height = 250)),
      
      )
    )
  )

