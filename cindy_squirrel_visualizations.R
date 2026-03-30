library(ggplot2)
data_table <- read.csv("central_park_og.csv")
clean_temp <- read.csv("central_park_numeric_temp.csv")

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

# bar graph breakdown by AM PM - stacked bars

sighters_by_time <- data_table %>%
  select(Date, Shift, Number.of.sighters) %>%
  mutate(Date = as.Date(as.character(Date), format = "%m%d%Y")) %>%
  group_by(Date, Shift) %>%
  summarise(Number.of.sighters = sum(Number.of.sighters, na.rm = TRUE), .groups = "drop")

ggplot(sighters_by_time, aes(x = Date, y = Number.of.sighters, fill = Shift)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = c("AM" = "#5BA08A", "PM" = "#B87333")) +
  labs(
    title = "Total Number of Sighters per Day - Breakdown by AM vs PM",
    x = "Date",
    y = "Number of Sighters",
    fill = "Time of Day"
  ) +
  scale_x_date(
    breaks = unique(sighters_by_time$Date),
    date_labels = "%b %d"
  ) +
  scale_y_continuous(breaks = seq(0, max(sighters_by_time$Number.of.sighters) + 150, by = 50)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# histogram of count of days and temperature

days_in_temp <- clean_temp %>%
  select(Date, numeric_temp) %>%
  mutate(Date = as.Date(as.character(Date), format = "%m%d%Y")) %>%
  group_by(Date) %>%
  summarise(numeric_temp = mean(numeric_temp, na.rm = TRUE), .groups = "drop")

ggplot(days_in_temp, aes(x = numeric_temp)) +
  geom_histogram(binwidth = 5, fill = "#8B4513", color = "white") +
  scale_x_continuous(breaks = seq(47.5, 78, by = 5), limits = c(45, 80)) +
  labs(
    title = "Count of Days within Temperature Ranges",
    x = "Temperature (°F)",
    y = "Count of Days"
  ) +
  theme_minimal()

# histogram of temperature and number of sighters

temp_sighters <- clean_temp %>%
  mutate(temp_bin = cut(numeric_temp, 
                        breaks = seq(40, 80, by = 5),
                        right = TRUE, include.lowest = TRUE)) %>%
  group_by(temp_bin) %>%
  summarise(Total_Sighters = sum(Number.of.sighters, na.rm = TRUE), .groups = "drop") %>%
  drop_na()

ggplot(temp_sighters, aes(x = temp_bin, y = Total_Sighters)) +
  geom_bar(stat = "identity", fill = "#8B4513", color = "white") +
  scale_y_continuous(breaks = seq(0, max(temp_sighters$Total_Sighters) + 50, by = 50)) +
  labs(
    title = "Number of Sighters by Temperature",
    x = "Temperature (°F)",
    y = "Number of Sighters"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# pie chart of when people are viewing squirrels

shift_sighters <- data_table %>%
  group_by(Shift) %>%
  summarise(Total_Sighters = sum(Number.of.sighters, na.rm = TRUE), .groups = "drop") %>%
  mutate(Percentage = Total_Sighters / sum(Total_Sighters) * 100,
         Label = paste0(round(Percentage, 1), "%\n(", Total_Sighters, ")"))

ggplot(shift_sighters, aes(x = "", y = Total_Sighters, fill = Shift)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  scale_fill_manual(values = c("AM" = "#5BA08A", "PM" = "#B87333")) +
  geom_text(aes(label = Label), position = position_stack(vjust = 0.5), 
            color = "white", size = 5) +
  labs(
    title = "Most Popular Time for Sighters to Squirrel Watch",
    fill = "Time of Day"
  ) +
  theme_void()
