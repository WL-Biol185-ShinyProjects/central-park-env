library(leaflet)
library(leaflet.extras)
central_park <- read_csv("central_park_og.csv")

# DENSITY MAP
leaflet(data = central_park)%>% 
  setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>% 
  addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
  addCircleMarkers(
    lng = ~X,
    lat = ~Y,
    radius = 2.5,
    color = "#8B4513",
    fillOpacity = 0.7,
    stroke = FALSE
  )

# HEAT MAP
leaflet(data = central_park) %>%
  setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>%
  addProviderTiles(providers$Esri.NatGeoWorldMap) %>%  
  addHeatmap(
    lng = ~X,
    lat = ~Y,
    blur = 25,      # how smooth/spread out the heat is
    max = 0.05,     # intensity ceiling
    radius = 17    # size of each point's influence
  ) %>%
  addControl(
    html = '
      <div style="background:white; padding:8px; border-radius:5px;">
        <b>Squirrel Density</b><br>
        <span style="color:#0000FF;">&#9632;</span> Low<br>
        <span style="color:#00FF00;">&#9632;</span> Medium<br>
        <span style="color:#FF0000;">&#9632;</span> High
      </div>',
    position = "bottomright"
  )


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
    radius = 3,
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
    radius = 3,
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
    radius = 3,
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

litter <- litter %>% mutate(litter_size = case_when(
  Litter == "None" ~ 2,
  Litter == "Some" ~ 5,
  Litter == "Abundant" ~ 9
))

pal <- colorFactor(
  palette = c("#00CC00", "#FFD700", "#FF0000"),
  levels = c("None", "Some", "Abundant")
)

leaflet(data = litter) %>% 
  setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>% 
  addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
  addCircleMarkers(
    lng = ~X,
    lat = ~Y,
    radius = ~litter_size,
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

# HUMAN MAP

# creating a new temp table where we look at NUMBER OF SIGHTERS

humans_table <- central_park %>% select(X, Y, "Number of sighters") %>% rename(num_sighters = `Number of sighters`)

leaflet(data = humans_table)%>% 
  setView(lng = -73.9683, lat = 40.7851, zoom = 14) %>% 
  addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
  addCircleMarkers(
    lng = ~X,
    lat = ~Y,
    radius = ~num_sighters * 3,
    color = "#8B4513",
    fillOpacity = 0.7,
    stroke = FALSE
  )
