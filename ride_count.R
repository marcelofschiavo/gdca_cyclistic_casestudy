install.packages("tidyverse")
install.packages("ggplot2")
library(scales)
library(tidyverse)
library(ggplot2)

summary_cyclist_riders <- read.csv("summary_riders_month.csv")

# Convert month_year to factor with desired order
summary_cyclist_riders$month_year <- factor(
  summary_cyclist_riders$month_year,
  levels = unique(summary_cyclist_riders$month_year)
)

# Plot line graph with inverted colors
ggplot(summary_cyclist_riders, aes(x = month_year, y = count_rides_casual, group = 1)) +
  geom_line(color = "#F8766D", linetype = "solid", show.legend = FALSE) +
  geom_point(color = "#F8766D", size = 3, show.legend = FALSE) +
  geom_line(aes(y = count_rides_member), color = "#00BFC4", linetype = "solid", show.legend = FALSE) +
  geom_point(aes(y = count_rides_member), color = "#00BFC4", size = 3, show.legend = FALSE) +
  labs(x = "", y = "", title = "Ride Count by Month") +
  scale_y_continuous(labels = function(x) paste0(x / 1000, "k")) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "bottom",
    legend.title = element_blank(),
    legend.text = element_text(color = c("#F8766D", "#00BFC4")),
    plot.caption = element_text(color = c("#F8766D", "#00BFC4"), size = 10)
  )
