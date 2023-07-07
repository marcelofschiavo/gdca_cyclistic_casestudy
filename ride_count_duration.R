install.packages("tidyverse")
install.packages("ggplot2")
library(scales)
library(tidyverse)
library(ggplot2)
summary_cyclist <- read.csv("summary_avgduration_countrides_wide.csv")

duration <- summary_cyclist$avg_ride_duration

time <- sub(".*\\s(\\d+:\\d+:\\d+\\.\\d+)", "\\1", duration)

# Split time into hours, minutes, and seconds
time_parts <- strsplit(time, "[:,]")
hours <- as.numeric(sapply(time_parts, "[", 1))
minutes <- as.numeric(sapply(time_parts, "[", 2))
seconds <- as.numeric(sapply(time_parts, "[", 3))

# Calculate total minutes
total_minutes <- (hours * 60) + minutes + (seconds / 60)

# Round total minutes to two decimal places
rounded_minutes <- round(total_minutes, 2)

# Add total minutes as a new column in the data frame
summary_cyclist <- mutate(summary_cyclist, total_minutes = rounded_minutes)

ggplot(summary_cyclist, aes(x = casual_member, y = total_minutes, fill = casual_member)) +
  geom_col(position = "dodge") +
  geom_text(aes(label = total_minutes), vjust = -0.4, color = "black", size = 3) +
  xlab("") +
  ylab("Minutes") +
  ggtitle("Average Ride Duration") +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_y_continuous(labels = label_number_si())

ggplot(summary_cyclist, aes(x = casual_member, y = count_ride, fill = casual_member)) +
  geom_col(position = "dodge") +
  geom_text(aes(label = count_ride), vjust = -0.4, color = "black", size = 3) +
  xlab("") +
  ylab("Rides") +
  ggtitle("Ride Count") +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_y_continuous(labels = label_number_si())

