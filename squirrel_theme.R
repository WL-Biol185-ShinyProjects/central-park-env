# Unified color palette
squirrel_colors <- c("#A0522D", "#CD853F", "#DEB887", "#8B4513", "#D2691E", "#F4A460")

# Bar chart theme
squirrel_theme <- function() {
  theme_minimal() +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold", size = 15, color = "#A0522D"),
      plot.subtitle = element_text(hjust = 0.5, color = "grey50", size = 11),
      axis.title = element_text(face = "bold", size = 12, color = "#5C3317"),
      axis.text = element_text(size = 11, color = "#5C3317"),
      panel.grid.major.x = element_blank(),
      panel.grid.minor = element_blank(),
      panel.grid.major.y = element_line(color = "#f0e6dc"),
      plot.background = element_rect(fill = "#fdf8f4", color = NA),
      panel.background = element_rect(fill = "#fdf8f4", color = NA)
    )
}

# Pie chart theme
squirrel_pie_theme <- function() {
  theme_void() +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold", size = 15, color = "#A0522D"),
      plot.subtitle = element_text(hjust = 0.5, color = "grey50", size = 11),
      legend.title = element_text(face = "bold", color = "#5C3317"),
      legend.text = element_text(color = "#5C3317"),
      legend.position = "bottom",
      plot.background = element_rect(fill = "#fdf8f4", color = NA)
    )
}