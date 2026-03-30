library(shiny)

attitude <- tabItem(tabName = "Attitude",
                    h2("Squirrel Attitude"),
                    fluidRow(
                      box(title = "Attitude Count", status = "warning", solidHeader = TRUE,
                          width = 6, plotOutput("squirrel_plot1", height = 350)),
                      box(title = "Attitude Breakdown", status = "warning", solidHeader = TRUE,
                          width = 6, plotOutput("squirrel_plot2", height = 350))
                    ),
                    fluidRow(
                      box(
                        title = "Attitude Observations", status = "warning", solidHeader = TRUE,
                        width = 12,
                        p("When the squirrel observer volunteers were monitoring squirrels,
        they took note of the squirrel's general demeanor by assigning it a description.
        They rated them as indifferent to the observer (indifferent), skittish to the
        observer when the squirrel would run away (runs from), or curious towards the
        observer when the squirrel approached the observer (approaches).",
                          br(), br(),
                          "Based on the 2018 Census Data, the majority of squirrels, 63%, were indifferent
        when an observer was present, 29% of the squirrels would run from the observer,
        and only 7% would approach the observer.",
                          br(), br(),
                          "When squirrels feel threatened, their response is often to escape or run away
        from the threat, however, in an urban area like Central Park, squirrels may be
        used to human activity, altering their responses to human activity. This attitude
        alteration may account for the majority of squirrels indifference to the
        observer's presence.",
                          br(), br(),
                          "In the 7% of squirrels that chose to approach the observer, it is possible the
        squirrel was approaching to ask for food. The 29% who ran from human observers
        are likely doing so because they perceive them as a threat or because they
        have a shy attitude.")
                      )
                    )
)

tail_behavior <- tabItem(tabName = "Tail_Behavior",
                         h2("Squirrel Tail Behavior"),
                         fluidRow(
                           box(title = "Tail Behavior Count", status = "warning", solidHeader = TRUE,
                               width = 6, plotOutput("squirrel_plot3", height = 350)),
                           box(title = "Tail Behavior Breakdown", status = "warning", solidHeader = TRUE,
                               width = 6, plotOutput("squirrel_plot4", height = 350))
                         ),
                         fluidRow(
                           box(
                             title = "Tail Behavior Observations", status = "warning", solidHeader = TRUE,
                             width = 8,
                             p("When the squirrel observer volunteers were monitoring squirrels, they took
        note of the tail movement of the squirrel which is indicative of squirrel
        communication. They rated the squirrel's tail movements as either twitches
        or flags and 74% of the movements noted were twitches.",
                               br(), br(),
                               "Squirrels have complex language systems, and one of the ways they communicate
        is through their tail movements. Tail twitches indicate that the squirrel is
        recognizing an alarm from a predator while a slower tail flag indicates the
        squirrel is signaling caution or annoyance.",
                               br(), br(),
                               "Since the majority of squirrels were seen twitching their tail, this indicates
        that the squirrel was aware of a nearby predator or was feeling threatened by
        the presence of humans. This tail signal result is somewhat contradictory to
        the attitudes exhibited by the squirrels, since the majority of them were noted
        as indifferent to the observer. The image to the right shows a slow flag and
        a fast twitch.")
                           ),
                           box(
                             title = "Tail Movement", status = "warning", solidHeader = TRUE,
                             width = 4,
                             img(src = "https://compote.slate.com/images/dc330a74-29be-4dbe-9e9f-e4117064c225.jpg?crop=1180%2C842%2Cx0%2Cy0",
                                 width = "100%", style = "border-radius: 8px; margin-top: 10px;")
                           )
                         )
)

activity <- tabItem(tabName = "Activity",
                    h2("Squirrel Activity"),
                    fluidRow(
                      box(title = "Activity Count", status = "warning", solidHeader = TRUE,
                          width = 6, plotOutput("squirrel_plot7", height = 350)),
                      box(title = "Activity Breakdown", status = "warning", solidHeader = TRUE,
                          width = 6, plotOutput("squirrel_plot8", height = 350))
                    ),
                    fluidRow(
                      box(
                        title = "Activity Observations", status = "warning", solidHeader = TRUE,
                        width = 6,
                        p("When the squirrel observer volunteers were monitoring squirrels,
        they took note of the activity the squirrel engaged in. The observers
        described the squirrels as foraging, eating, running, climbing, chasing.",
                          br(), br(),
                          "37% of the squirrels were foraging when they were encountered, 20% were
        eating, 19% were running, 17% were climbing, and only 7% of squirrels
        were chasing another squirrel.",
                          br(), br(),
                          "Because these observations were made in the fall, the activities observed
        align with typical squirrel activity for this time of year.")
                      ),
                      box(
                        title = "Squirrels in Action", status = "warning", solidHeader = TRUE,
                        width = 6,
                        tags$iframe(
                          width = "100%", height = "300",
                          src = "https://www.youtube.com/embed/_9ZjgeSKkeQ?si=Y9kPAVL9Bg1uuLJ0",
                          frameborder = "0", allowfullscreen = NA,
                          style = "border-radius: 8px;"
                        )
                      ) 
                    ),  
                  fluidRow(
                        tabBox(
                          title = "Squirrel Activity by age",
                          width = 12,
                          tabPanel("Juvenile",
                                   plotOutput("juvenileCloud", height = "400px", width = "100%")
                          ),
                          tabPanel("Adult",
                                   plotOutput("adultCloud")
                                   
                          )
                        )
                  )

)

noise <- tabItem(tabName = "Noise",
                 h2("Squirrel Noise"),
                 fluidRow(
                   box(title = "Noise Count", status = "warning", solidHeader = TRUE,
                       width = 6, plotOutput("squirrel_plot5", height = 350)),
                   box(title = "Noise Breakdown", status = "warning", solidHeader = TRUE,
                       width = 6, plotOutput("squirrel_plot6", height = 350))
                 ),
                 fluidRow(
                   box(
                     title = "Noise Observations", status = "warning", solidHeader = TRUE,
                     width = 12,
                     p("When the squirrel observer volunteers were monitoring squirrels, they took
        note of the noise the squirrel was making. The noises the observer noted
        were kuks, quaas, or moans.",
                       br(), br(),
                       "Kuks are noises that signal to other squirrels that there could be predators
        around or may indicate the squirrel is annoyed. Quaas are another sound that
        alert squirrels of predators which can include humans. Moans also signal
        predators but are typically vocalized in response to lower-threat predators.
        Since all of these noises signal some level of agitation or fear, they are
        typically paired with the tail twitches.",
                       br(), br(),
                       "65% of sounds noted were kuks, 33% were quaas, and only 3% were moans.
        Similar to the results from tail behavior, the squirrels that were encountered
        seemed to exhibit some level of agitation/fear from nearby threats. These
        threats could be the presence of humans in the busy park.",
                       br(), br(),
                       "Please press the noises below to hear what they sound like."),
                     hr(),
                     fluidRow(
                       column(4,
                              h5("🐿️ Kuk"),
                              p("Short sharp alarm call", style = "color: grey; font-size: 13px;"),
                              tags$audio(src = "kuk.mp3", type = "audio/mp3", controls = TRUE)
                       ),
                       column(4,
                              h5("🐿️ Quaa"),
                              p("Drawn out predator alert", style = "color: grey; font-size: 13px;"),
                              tags$audio(src = "quaa.mp3", type = "audio/mp3", controls = TRUE)
                       ),
                       column(4,
                              h5("🐿️ Moan"),
                              p("Low threat predator signal", style = "color: grey; font-size: 13px;"),
                              tags$audio(src = "moan.mp3", type = "audio/mp3", controls = TRUE)
                       )
                     )
                   )
                 )
)
