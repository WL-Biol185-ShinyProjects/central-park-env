about_us <- tabItem(tabName = "about_us",
                    fluidRow(
                      column(width = 12,
                             h2("About Us"),
                             hr()
                      )
                    ),
                    fluidRow(
                      box(width = 12,
                          h3("Meet the Team"),
                          hr(),
                          fluidRow(
                            column(width = 2,
                                   img(src = "person1.jpeg",
                                       style = "border-radius: 50%; width: 150px; height: 150px; object-fit: cover;")
                            ),
                            column(width = 10,
                                   h3("Ava Grace Flory"),
                                   p("Ava Grace Flory is a senior Biology and Environmental Studies double major
            who plans to pursue an MD/PhD with a focus on infectious disease. After graduation 
            she hopes to work in zoonotic disease research. She finds squirrels interesting because
            of the risk of disease transmission from squirrels to humans.")
                            )
                          ),
                          hr(),
                          fluidRow(
                            column(width = 2,
                                   img(src = "person2.jpeg",
                                       style = "border-radius: 50%; width: 150px; height: 150px; object-fit: cover;")
                            ),
                            column(width = 10,
                                   h3("Cindy Xie"),
                                   p("Cindy is a senior Econ major and a double minor in Data Science and Chinese. 
            She will be in D.C. after graduation working at a consulting firm. She hopes to
            use her data analysis skills to help in the policy world in the future. She thinks
            building our NYC squirrels webapp is a fun way to build her R skills!")
                            )
                          ),
                          hr(),
                          fluidRow(
                            column(width = 2,
                                   img(src = "person3.jpeg",
                                       style = "border-radius: 50%; width: 150px; height: 150px; object-fit: cover;")
                            ),
                            column(width = 10,
                                   h3("Jenna Moore"),
                                   p("Jenna is a junior Biology and Environmental Studies double major hoping to pursue
            a PhD in ecology after undergrad. Jenna's greater academic and career goal is to
            teach upper level biology in either a high school or small college setting focusing
            on how the biological world is so much less distant than people might think. Jenna
            is interested in squirrels because of how common they are in everyday life despite
            how much there is to learn.")
                            )
                          ),
                          hr(),
                          fluidRow(
                            column(width = 2,
                                   img(src = "person4.jpeg",
                                       style = "border-radius: 50%; width: 150px; height: 150px; object-fit: cover;")
                            ),
                            column(width = 10,
                                   h3("Emma Batty"),
                                   p("Emma is a sophomore Neuroscience major with a Poverty & Human Capability Studies
            minor hoping to pursue an MD/PhD with a focus in innovative drug delivery systems
            and pediatric oncology. She enjoys spending time outdoors and finds the behavior
            and complexity of social interactions between little critters astonishing, so she
            has found these datasets on central park squirrels fun to dive into and analyze!")
                            )
                          )
                      )
                    ),
                    fluidRow(
                      box(
                        title = "Citations",
                        width = 12,
                        tags$ul(
                          tags$li(
                            tags$a("NYC Open Data - 2018 Central Park Squirrel Census Squirrel Data",
                                   href = "https://data.cityofnewyork.us/Environment/2018-Central-Park-Squirrel-Census-Squirrel-Data/vfnx-vebw/about_data",
                                   target = "_blank")
                          ),
                          tags$li(
                            tags$a("Skedaddle Wildlife - Do Squirrels Communicate with Humans",
                                   href = "https://www.skedaddlewildlife.com/location/vaughan/blog/do-squirrels-communicate-with-humans",
                                   target = "_blank")
                          ),
                          tags$li(
                            tags$a("Wildlife Online - Squirrel Activity",
                                   href = "https://www.wildlifeonline.me.uk/animals/article/squirrel-activity",
                                   target = "_blank")
                          ),
                          tags$li(
                            tags$a("Slate - Squirrels Express Frustration by Twitching Their Tails",
                                   href = "https://slate.com/technology/2016/05/squirrels-express-frustration-by-twitching-their-tails-researchers-say.html",
                                   target = "_blank")
                          ),
                          tags$li(
                            tags$a("Wired - Squirrel Alarm Calls Are Surprisingly Complex",
                                   href = "https://www.wired.com/2014/06/squirrel-alarm-calls-are-surprisingly-complex/",
                                   target = "_blank")
                          ),
                          tags$li(
                            tags$a("Nature.org - Squirrel Parkour: The Science Behind Squirrel Acrobatics",
                                   href = "https://blog.nature.org/2021/11/16/squirrel-parkour-the-science-behind-squirrel-acrobatics/",
                                   target = "_blank")
                          ),
                          tags$li(
                            tags$a("Xeno-canto - Sciurus carolinensis",
                                   href = "https://xeno-canto.org/species/Sciurus-carolinensis",
                                   target = "_blank")
                          ),
                          tags$li(
                            tags$a("National Wildlife Federation - 10 Nutty Facts to Make You Appreciate Squirrels",
                                   href = "https://blog.nwf.org/2015/01/10-nutty-facts-to-make-you-appreciate-squirrels/",
                                   target = "_blank")
                          ),
                          tags$li(
                            tags$a("Wildlife Online - Why Are Some Squirrels of the Same Species Different Colours",
                                   href = "https://www.wildlifeonline.me.uk/questions/answer/why-are-some-squirrels-of-the-same-species-different-colours",
                                   target = "_blank")
                          ),
                          tags$li(
                            "Please note: Claude was also used as a tool for code."
                          )
                        )
                      ),
                      
                    fluidRow(
                      box(width = 12,
                          div(style = "text-align: center;",
                              tags$img(
                                src = "https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExb2ltNmdiYTN3OG85eXgyNmJrMWNtMndkZHEwcW5rdGxiZ2hqZ2d0NSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Nr6PZhbX2jGuearCgU/giphy.gif",
                                width = "300px",
                                style = "border-radius: 12px;"
                              ),
                              br(),
                              p("Thanks for exploring Central Park squirrels with us! 🐿️",
                                style = "font-size: 18px; font-weight: bold; color: #A0522D;")
                          )
                      )
                    )
                  )
)