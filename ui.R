library(shinydashboard)

dashboardPage((skin = "#652A0E"),
  dashboardHeader(title = "Squirrel Exploration"),
  dashboardSidebar(title = "What's the squirrel doing?"),
  dashboardBody(
    fluidRow(
      box(plotOutput("squirrel_plot", height = 250)), box(plotOutput("squirrel_plot2", height = 250)
    )
  )
))