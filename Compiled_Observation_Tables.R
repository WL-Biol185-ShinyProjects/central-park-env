library(tidyverse)
library(dplyr) # joining the datasets together
library(purrr)

squirrel_data <- read_csv("~/central-park-env/raw_data/2018_Central_Park_Squirrel_Census_-_Squirrel_Data_20260216.csv")
hectare_data <- read_csv("~/central-park-env/raw_data/2018_Central_Park_Squirrel_Census_-_Hectare_Data_20260216.csv")
story_data <- read_csv("~/central-park-env/raw_data/2018_Central_Park_Squirrel_Census_-_Stories_20260216 (1).csv")

df_list <- list(squirrel_data, hectare_data, story_data) # add all your dataframes to a list

central_park_og <- df_list %>%
  reduce(inner_join, by = c("Hectare", "Shift", "Date"))

write.csv(central_park_og, "central_park_og.csv", row.names = FALSE)

central_park_act_obs <- central_park_og %>%
  pivot_longer(
    cols = c(Running, Chasing, Climbing, Eating, Foraging),
    names_to = "activity",
    values_to = "did_activity"
  ) %>%
  select("Unique Squirrel ID", "activity", "did_activity")

central_park_noise_obs <- central_park_og %>%
  pivot_longer(
    cols = c(Kuks, Quaas, Moans),
    names_to = "noise",
    values_to = "made_noise"
  ) %>%
  select("Unique Squirrel ID", "noise", "made_noise")

central_park_tailbeh_obs <- central_park_og %>%
  pivot_longer(
    cols = c("Tail flags", "Tail twitches"),
    names_to = "tailbehavior",
    values_to = "did_tailbehavior"
  ) %>%
  select("Unique Squirrel ID", "tailbehavior", "did_tailbehavior")

central_park_attitude <- central_park_og %>%
  pivot_longer(
    cols = c("Approaches", "Indifferent", "Runs from"),
    names_to = "attitude",
    values_to = "did_attitude"
  ) %>%
  select("Unique Squirrel ID", "attitude", "did_attitude")

