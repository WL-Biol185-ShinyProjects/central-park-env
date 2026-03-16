library(leaflet)
library(leaflet.extras)
central_park <- read_csv("central_park_og.csv")
View(central_park)

# DENSITY MAP
leaflet(data = central_park)%>% 
  setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>% 
  addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
  addCircleMarkers(
    lng = ~X,
    lat = ~Y,
    radius = 2,
    color = "brown",
    fillOpacity = 0.7,
    stroke = FALSE
  )

# HEAT MAP
leaflet(data = central_park) %>%
  setView(lng = -73.9683, lat = 40.7851, zoom = 20) %>%
  addProviderTiles(providers$Esri.NatGeoWorldMap) %>%  
  addHeatmap(
    lng = ~X,
    lat = ~Y,
    blur = 25,      # how smooth/spread out the heat is
    max = 0.05,     # intensity ceiling
    radius = 17    # size of each point's influence
  ) # blue is low density, green/yellow is med density, red is high density


# creating a new temp table where we look at AGE (removing "NA" and "?" first)

age_table <- central_park %>% select(X, Y, Age)
age_table[age_table == "?"] <- NA
age <- age_table %>% drop_na()

# AGE MAP

pal <- colorFactor(
  palette = c("#FFD700", "#FF4500"),
  levels = c("Adult", "Juvenile")
)

leaflet(data = age)%>% 
  setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>% 
  addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
  addCircleMarkers(
    lng = ~X,
    lat = ~Y,
    radius = 2,
    color = ~pal(Age),
    fillOpacity = 0.7,
    stroke = FALSE
  ) %>%
  addLegend(
    position = "bottomright",
    pal = pal,
    values = ~Age,
    title = "Squirrel Age"
  )

# creating a new temp table where we look at FUR COLOR (removing "NA" first)

fur_table <- central_park %>% select(X, Y, "Primary Fur Color")
fur <- fur_table %>% drop_na()
fur <- fur %>% rename(fur_color = `Primary Fur Color`)

# FUR MAP
pal <- colorFactor(
  palette = c("#696969", "#FF6B00", "#000000"),
  levels = c("Gray", "Cinnamon", "Black")
)

leaflet(data = fur)%>% 
  setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>% 
  addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
  addCircleMarkers(
    lng = ~X,
    lat = ~Y,
    radius = 2,
    color = ~pal(fur_color),
    fillOpacity = 0.7,
    stroke = FALSE
  ) %>%
  addLegend(
    position = "bottomright",
    pal = pal,
    values = ~fur_color,
    title = "Squirrel Color"
  )

# creating a new temp table where we look at LITTER (removing "NA" first)

litter_table <- central_park %>% select(X, Y, Litter)
litter <- litter_table %>% drop_na()

# LITTER MAP 1

pal <- colorFactor(
  palette = c("#00CC00", "#FFD700", "#FF0000"),
  levels = c("None", "Some", "Abundant")
)

leaflet(data = litter)%>% 
  setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>% 
  addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
  addCircleMarkers(
    lng = ~X,
    lat = ~Y,
    radius = 2,
    color = ~pal(Litter),
    fillOpacity = 0.7,
    stroke = FALSE
  ) %>%
  addLegend(
    position = "bottomright",
    pal = pal,
    values = ~Litter,
    title = "Litter Amount"
  )

# LITTER MAP 2







