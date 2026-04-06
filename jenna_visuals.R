library(ggwordcloud)
library(dplyr, quietly = TRUE)


# creation of frequency table filtered to TRUE and consolidating to young
output$juvenileCloud <- renderPlot({ 
  word_freq <- central_park_act_obs_age %>%
    filter(did_activity == TRUE) %>%
    filter(Age == "Juvenile") %>%
    count(activity, name = "n") %>%
    mutate(angle = 90 * sample(c(0,1),n(), replace = TRUE, prob = c(60, 40)))

set.seed(35)
ggplot(word_freq, aes(label = activity, size = n, angle = angle)) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 25) +
  theme_minimal()
  
})


# creation of frequency table filtered to TRUE and consolidating to adult
output$adultCloud <- renderPlot({ 
  word_freq <- central_park_act_obs_age %>%
    filter(did_activity == TRUE) %>%
    filter(Age == "Adult") %>%
    count(activity, name = "n") %>%
    mutate(angle = 90 * sample(c(0,1),n(), replace = TRUE, prob = c(60, 40)))
  
  set.seed(35)
  ggplot(word_freq, aes(label = activity, size = n, angle = angle)) +
    geom_text_wordcloud() +
    scale_size_area(max_size = 25) +
    theme_minimal()
  
})


#buzzfeed like quiz test 
output$quizUI <- renderUI({
  tagList(
    h3("What Type of Squirrel Are You?"),
    
    radioButtons("q1", "1. What is your ideal Saturday morning?",
                 choices = c("Sleeping in and having a big breakfast",
                             "Getting outside for a run",
                             "Exploring somewhere new",
                             "Staying cozy inside with a book")),
    
    radioButtons("q2", "2. What is your social style?",
                 choices = c("I love being around lots of people",
                             "I prefer a small close group of friends",
                             "I am a lone wolf",
                             "It depends on my mood")),
    
    radioButtons("q3", "3. How do you handle stress?",
                 choices = c("I run away from it",
                             "I face it head on",
                             "I distract myself with food",
                             "I climb to a higher perspective")),
    
    radioButtons("q4", "4. What is your favorite season?",
                 choices = c("Fall - cozy and full of snacks",
                             "Spring - fresh and full of energy",
                             "Summer - warm and adventurous",
                             "Winter - quiet and peaceful")),
    
    radioButtons("q5", "5. What is your ideal snack?",
                 choices = c("Nuts and seeds",
                             "Fruit and berries",
                             "Something warm and hearty",
                             "Whatever I can find")),
    
    radioButtons("q6", "6. How would your friends describe you?",
                 choices = c("Energetic and always on the move",
                             "Warm and nurturing",
                             "Mysterious and independent",
                             "Clever and resourceful")),
    
    radioButtons("q7", "7. What is your favorite place to hang out?",
                 choices = c("Up high with a great view",
                             "In a cozy hidden spot",
                             "Somewhere busy with lots going on",
                             "Out in an open field")),
    
    radioButtons("q8", "8. What do you do when you find something valuable?",
                 choices = c("Share it with others",
                             "Save it for later",
                             "Enjoy it right away",
                             "Hide it somewhere secret")),
    
    actionButton("submit_quiz", "Find Out My Squirrel Type!"),
    uiOutput("quiz_result")
  )
})

observeEvent(input$submit_quiz, {
  
  scores <- list(
    q1 = c("Sleeping in and having a big breakfast" = 2,
           "Getting outside for a run" = 3,
           "Exploring somewhere new" = 1,
           "Staying cozy inside with a book" = 2),
    q2 = c("I love being around lots of people" = 2,
           "I prefer a small close group of friends" = 1,
           "I am a lone wolf" = 3,
           "It depends on my mood" = 2),
    q3 = c("I run away from it" = 3,
           "I face it head on" = 2,
           "I distract myself with food" = 1,
           "I climb to a higher perspective" = 2),
    q4 = c("Fall - cozy and full of snacks" = 1,
           "Spring - fresh and full of energy" = 2,
           "Summer - warm and adventurous" = 3,
           "Winter - quiet and peaceful" = 2),
    q5 = c("Nuts and seeds" = 1,
           "Fruit and berries" = 2,
           "Something warm and hearty" = 2,
           "Whatever I can find" = 3),
    q6 = c("Energetic and always on the move" = 3,
           "Warm and nurturing" = 2,
           "Mysterious and independent" = 1,
           "Clever and resourceful" = 2),
    q7 = c("Up high with a great view" = 2,
           "In a cozy hidden spot" = 1,
           "Somewhere busy with lots going on" = 3,
           "Out in an open field" = 2),
    q8 = c("Share it with others" = 2,
           "Save it for later" = 1,
           "Enjoy it right away" = 3,
           "Hide it somewhere secret" = 2)
  )
  
  total <- scores$q1[input$q1] + scores$q2[input$q2] +
    scores$q3[input$q3] + scores$q4[input$q4] +
    scores$q5[input$q5] + scores$q6[input$q6] +
    scores$q7[input$q7] + scores$q8[input$q8]
  
  output$quiz_result <- renderUI({
    result <- if (total <= 10) {
      tagList(
        h2("You are a Black Squirrel!"),
        p("You are rare, mysterious, and independent. You march to the beat of
          your own drum and are not afraid to stand out from the crowd. Like the
          black squirrel, you are striking and unforgettable!")
      )
    } else if (total <= 14) {
      tagList(
        h2("You are a Cinnamon Squirrel!"),
        p("You are warm, adventurous, and full of energy. You bring a little spice
          to everything you do and love exploring new places. Like the cinnamon
          squirrel, you are vibrant and full of life!")
      )
    } else {
      tagList(
        h2("You are a Gray Squirrel!"),
        p("You are clever, resourceful, and adaptable. You thrive in any environment
          and are always prepared for what comes next. Like the gray squirrel, you
          are a true survivor and the backbone of your community!")
      )
    }
    result
  })
})

squirrel_quiz <- tabItem(tabName = "quiz",
                         fluidRow(
                           box(
                             title = "What Type of Squirrel Are You?",
                             width = 12,
                             uiOutput("quizUI")
                           )
                         )
)

