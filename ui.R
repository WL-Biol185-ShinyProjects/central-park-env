library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "Squirrel Exploration"),
  dashboardSidebar(title = "What's the squirrel doing?"),
  dashboardBody(
    fluidRow(
      box(plotOutput("squirrel_plot", height = 250))
    )
  )
)