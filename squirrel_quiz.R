squirrel_quiz <- tabItem(tabName = "squirrel_quiz",
        fluidRow(
          box(
            title = "What Type of Squirrel Are You?",
            width = 12,
            uiOutput("quizUI")
          )
        )
)