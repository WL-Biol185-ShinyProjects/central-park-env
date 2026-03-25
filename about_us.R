about_us <- tabItem(tabName = "about_us",
                    fluidRow(
                      column(width = 12,
                             h2("About Us"),
                             hr()
                      )
                    ),
                    fluidRow(
                      box(width = 12,
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
                                     a PhD in ecology after undergrad. Jenna’s greater academic and career goal is to
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
                                     has found these datasets on central park squirrels fun to dive into and analyze! ")
                            )
                          )
                      )
                    )
)
