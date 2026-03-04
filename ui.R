library(shiny)
library(bslib)


ui <- page_sidebar(
  title = "Squirrel Exploration",
  sidebar = sidebar("Activities"),
  "main contents"
)

