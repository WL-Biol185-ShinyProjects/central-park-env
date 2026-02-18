library(tidyverse)
library(dplyr) # joining the datasets together
library(purrr)

squirrel_data <- read_csv("~/central-park-env/raw_data/2018_Central_Park_Squirrel_Census_-_Squirrel_Data_20260216.csv")
hectare_data <- read_csv("~/central-park-env/raw_data/2018_Central_Park_Squirrel_Census_-_Hectare_Data_20260216.csv")
story_data <- read_csv("~/central-park-env/raw_data/2018_Central_Park_Squirrel_Census_-_Stories_20260216 (1).csv")

df_list <- list(squirrel_data, hectare_data, story_data) # add all your dataframes to a list

central_park_tf <- df_list %>%
  reduce(inner_join, by = c("Hectare", "Shift", "Date"))

<<<<<<< HEAD


=======
View(central_park_tf)
>>>>>>> f413e08de83c2e001f7e4dbbe995fef466dde736
