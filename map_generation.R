library(leaflet)
library(leaflet.extras)
central_park <- read_csv("central_park_og.csv")
View(central_park)

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

