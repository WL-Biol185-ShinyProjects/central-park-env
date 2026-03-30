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




