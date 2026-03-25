library(ggplot2)
data_table <- read.csv("central_park_og.csv")

# bar graph no breakdown

total_daily_sighters <- data_table %>%
  select(Date, Number.of.sighters) %>%
  mutate(Date = as.Date(as.character(Date), format = "%m%d%Y")) %>%
  group_by(Date) %>%
  summarise(total_daily_sighters = sum(Number.of.sighters, na.rm = TRUE), .groups = "drop")

ggplot(total_daily_sighters, aes(x = Date, y = total_daily_sighters)) +
  geom_bar(stat = "identity", fill = "#8B4513") +
  labs(
    title = "Total Number of Sighters per Day",
    x = "Date",
    y = "Number of Sighters"
  ) +
  scale_x_date(
    breaks = unique(total_daily_sighters$Date),
    date_labels = "%b %d"
  ) +
  scale_y_continuous(breaks = seq(0, max(total_daily_sighters$total_daily_sighters) + 100, by = 50)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# bar graph breakdown by AM PM - stacked

sighters <- data_table %>%
  select(Date, Shift, Number.of.sighters) %>%
  mutate(Date = as.character(Date),
         Date = as.Date(Date, format = "%m%d%Y")) %>%
  group_by(Date, Shift) %>%
  summarise(Total_Sighters = sum(Number.of.sighters, na.rm = TRUE), .groups = "drop")