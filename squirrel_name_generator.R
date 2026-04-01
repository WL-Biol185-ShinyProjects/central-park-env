library(shiny)
library(shinydashboard)

squirrel_name_generator <- tabItem(tabName = "squirrel_name_generator",
                                   h2("🐿️ Squirrel Name Generator"),
                                   fluidRow(
                                     box(
                                       title = "What is your Central Park Squirrel Name?",
                                       status = "warning", solidHeader = TRUE,
                                       width = 12,
                                       div(style = "text-align: center;",
                                           p("Click the button below to discover your Central Park squirrel identity!"),
                                           actionButton("generate_name", "Generate My Squirrel Name! 🐿️",
                                                        style = "background-color: #A0522D; color: white;
                              border: none; font-size: 16px; padding: 10px 20px;"),
                                           br(), br(),
                                           h3(textOutput("squirrel_name"),
                                              style = "color: #A0522D; font-weight: bold;")
                                       )
                                     )
                                   ),
                                   fluidRow(
                                     box(
                                       title = "How it Works", status = "warning", solidHeader = TRUE,
                                       width = 12,
                                       p("Your squirrel name is made up of four parts:",
                                         br(), br(),
                                         strong("Adjective"), " — describes your personality",
                                         br(),
                                         strong("Name"), " — your squirrel first name",
                                         br(),
                                         strong("Activity"), " — what you're known for doing",
                                         br(),
                                         strong("Location"), " — your home in Central Park"
                                       )
                                     )
                                   )
)