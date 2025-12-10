# 1. Load your toolkit
library(tidyverse)  # specific for data cleaning
library(skimr)  #
library(janitor)    # for cleaning column names
install.packages(scales)

# 2. Import and Merge Data
# Assuming your 12 CSV files are in a folder named 'csv_files' in your project directory
file_paths <- list.files("C:/Users/a2z/Downloads/Cyclistic", pattern = ".csv", full.names = TRUE)

# This magic command reads all files and stacks them into one table
all_trips <- file_paths %>% 
  map_dfr(read_csv)

# 3. Quick check of the data
glimpse(all_trips_v2)
head(all_trips)
str(all_trips)
skim_without_charts(all_trips_clean)

# 1. Clean names and remove empty rows
all_trips_v2 <- all_trips %>% 
  clean_names() %>%            # Fixes Column Names (e.g., "Ride ID" -> "ride_id")
  drop_na() %>%                # Removes rows with any empty cells (SQL: IS NULL)
  distinct(ride_id, .keep_all = TRUE) # Removes duplicate rows if any

# 2. Add calculation columns (SQL: EXTRACT(HOUR...))
all_trips_v2 <- all_trips_v2 %>% 
  mutate(
    # Create ride_length in minutes
    ride_length = as.numeric(difftime(ended_at, started_at, units = "mins")),
    
    # Extract day, month, year for analysis
    day_of_week = wday(started_at, label = TRUE, abbr = FALSE),
    month = month(started_at, label = TRUE, abbr = FALSE),
    year = year(started_at)
  )

# 3. Filter bad data (SQL: WHERE ride_length > 1 AND ride_length < 1440)
# We also remove "HQ QR" which are administrative rides mentioned in the case study
all_trips_clean <- all_trips_v2 %>% 
  filter(ride_length > 1) %>%        # Remove rides < 1 min (false starts)
  filter(ride_length < 1440) %>%     # Remove rides > 24 hours (stolen/forgotten)
  filter(start_station_name != "HQ QR") # Remove testing station

# Calculate mean, median, max, min for each user type
summary_stats <- all_trips_clean %>% 
  group_by(member_casual) %>% 
  summarise(
    average_duration = mean(ride_length),
    median_duration = median(ride_length),
    max_duration = max(ride_length),
    total_rides = n()
  )

print(summary_stats)

# See which days are most popular
daily_usage <- all_trips_clean %>% 
  group_by(member_casual, day_of_week) %>% 
  summarise(
    number_of_rides = n(),
    average_duration = mean(ride_length),
    .groups = "drop"
  ) %>% 
  arrange(member_casual, day_of_week)

print(daily_usage)

ggplot(data = daily_usage) +
  aes(x = day_of_week, y = number_of_rides, fill = member_casual) +
  geom_col(position = "dodge") +
  labs(title = "Total Rides per Day: Member vs Casual",
       y = "Number of Rides", x = "Day of Week") +
  scale_y_continuous(labels = scales::comma)

# 1. Prepare the data: Count and calculate percentages
user_dist <- all_trips_clean %>%
  count(member_casual) %>%
  mutate(perc = n / sum(n)) %>% 
  mutate(labels = scales::percent(perc))

# 2. Plot
ggplot(user_dist, aes(x = "", y = perc, fill = member_casual)) +
  geom_col(color = "white") +
  coord_polar(theta = "y") + # This turns the bar chart into a circle
  geom_text(aes(label = labels), position = position_stack(vjust = 0.5)) +
  theme_void() + # Removes the background grid/axes
  labs(title = "Distribution of Rider Types", fill = "Rider Type")

# 1. Prepare Data: Group by Month and User Type
monthly_trend <- all_trips_clean %>% 
  mutate(month = floor_date(started_at, "month")) %>% # Round dates to the 1st of the month
  group_by(month, member_casual) %>% 
  summarise(number_of_rides = n(), .groups = "drop")

# 2. Plot Line Chart
ggplot(monthly_trend, aes(x = month, y = number_of_rides, color = member_casual)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  scale_y_continuous(labels = comma) + # Adds commas to large numbers
  labs(title = "Monthly Ride Trends", 
       subtitle = "Casual riders peak significantly in summer months",
       x = "Month", y = "Number of Rides") +
  theme_minimal()

# Export the clean dataframe to a CSV file
write_csv(all_trips_clean, "C:/Users/a2z/Downloads/cyclistic_final_cleaned_data.csv")
