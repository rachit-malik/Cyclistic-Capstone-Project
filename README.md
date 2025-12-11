# Google Data Analytics Capstone: Cyclistic Bike-Share Case Study 🚴‍♀️

##  Introduction
This is the Capstone project for the **Google Data Analytics Professional Certificate**. 

**Scenario:** I am a junior data analyst working in the marketing analyst team at **Cyclistic**, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently.

Course: [Google Data Analytics Capstone: Complete a Case Study](https://www.coursera.org/learn/google-data-analytics-capstone)

**Objective:** Design marketing strategies aimed at converting casual riders into annual members.

---

##  1. Ask Phase
**Business Task:** Analyze historical bike trip data to identify trends in how **Annual Members** and **Casual Riders** use Cyclistic bikes differently.

**Key Stakeholders:**
* **Lily Moreno:** Director of Marketing (My manager).
* **Cyclistic Executive Team:** The detailed-oriented executive team who will decide whether to approve the recommended marketing program.

**Guiding Questions:**
1.  How do annual members and casual riders use Cyclistic bikes differently?
2.  Why would casual riders buy Cyclistic annual memberships?
3.  How can Cyclistic use digital media to influence casual riders to become members?

Lily Moreno asked me to answer the 1st Question - How do annual members and casual riders use Cyclistic bikes differently?

---

##  2. Prepare Phase
**Data Source:** I used 12 months of Cyclistic's historical trip data (public data provided by Motivate International Inc.).
* **Dataset:** [Cyclistic Trip Data](https://divvy-tripdata.s3.amazonaws.com/index.html)
* **Date Range:** [Insert Date Range, e.g., Jan 2022 - Dec 2022]
* **Privacy:** Riders' personal identifiable information (PII) has been removed, prohibiting analysis of individual user demographics (age, gender, address).

**Data Organization:** The data is stored in monthly CSV files. Each file contains 13 columns, including:
* `ride_id` (Unique ID)
* `rideable_type` (Classic, Electric, Docked)
* `started_at` & `ended_at` (Timestamps)
* `start_station_name` & `end_station_name`
* `member_casual` (User Type)

---

##  3. Process Phase
**Tools Used:** * **R Studio:** Chosen for its ability to handle large datasets (millions of rows) and for reproducible data cleaning.
* **Power BI:** Chosen for creating interactive dashboards and geospatial visualizations.

**Cleaning & Manipulation Steps (R Studio):**
I began by importing the data and inspecting the structure.
[R Code Imports](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/rscript.R)
[R_markdownfile](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/Cyclistic-Bike-Share-Analysis-Capstone.rmd)
[R_markdown_pdf](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/Cyclistic-Bike-Share-Analysis-Capstone.pdf)

1.  **Consolidation:** Merged 12 monthly CSV files into a single dataframe (`all_trips`) containing millions of records.

![skim_without_charts](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Screenshot%202025-12-09%20011603.png?raw=true)
2.  **Standardization:** Used `janitor::clean_names()` to ensure consistent column naming.

![cleaning names and removing empty rows](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Screenshot%202025-12-09%20014014.png?raw=true)
3.  **Calculations:**
    * Created `ride_length` by subtracting `started_at` from `ended_at`.
    * Extracted `day_of_week`, `month`, and `year` for granular time-based analysis.
    
![adding_calculation columns](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Screenshot%202025-12-09%20014708.png?raw=true)
4.  **Data Quality Check:**
    * Removed "bad data" where `ride_length` was negative or less than 1 minute (false starts).
    * Removed outlier rides longer than 24 hours (stolen/unreturned bikes).
    * Removed administrative test rides (`start_station_name` = "HQ QR").
    
    ![filter_data](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Screenshot%202025-12-09%20020855.png?raw=true)
    
5. **checking and conforming the changes in the data:**
    * After cleaning the data to check the changes we run `skim_without_charts` to get summary of our data.
    * 4291805 rows left after data cleaning (removed unnessasary or rows with no clear data(bad data)[1375912 rows removed])
    *  2 columns we added `days_of_week`,`month`.
    
    ![skim_without_charts_afterdataclean](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Screenshot%202025-12-09%20021041.png?raw=true)

*The full R cleaning script is available in this repository as `analysis.Rmd`.*

---

##  4. Analyze Phase
**Goal:** Identify patterns and relationships in the cleaned data.

**Key Analysis Performed in R:**
* **Descriptive Statistics:** Calculated Mean, Median, Max, and Min for ride duration.
* **Aggregation:** Grouped data by `member_casual` and `day_of_week` to compare volume and duration.

  ![data_analyze](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Screenshot%202025-12-09%20021551.png?raw=true)

**Findings:**
1.  **Duration:** Casual riders take significantly longer rides (Mean: ~24 mins) compared to Members (Mean: ~12 mins).
2.  **Frequency:** Members ride more frequently but for shorter durations, implying utility/commute.
3.  **Seasonality:** Both groups peak in summer, but Casual ridership drops drastically in winter.

![findings](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Screenshot%202025-12-09%20021604.png?raw=true)

---

##  5. Share Phase
I exported the cleaned and aggregated data to **Power BI** to create an interactive dashboard. The visualizations below tell the story of the data.

### A. Weekly Riding Habits: Commute vs. Leisure
**Why this chart?** To understand the "when" of rider usage.
**Observation:**
* **Members (Dark Blue):** Dominant on weekdays (Mon-Fri), peaking at 8 AM and 5 PM. This confirms they use the service for commuting to work.
* **Casuals (Light Blue):** Dominant on weekends (Sat-Sun), indicating leisure or tourism activity.
![Weekly Habits](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Screenshot%202025-12-11%20034152.png?raw=true)

### B. Average Ride Duration: "A to B" vs. Exploration
**Why this chart?** To understand the "how" of rider usage.
**Observation:**
Casual riders keep bikes nearly **2x longer** than members. This suggests Members value speed and efficiency, while Casuals value the experience and exploration.
![Ride Duration](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Screenshot%202025-12-11%20034353.png?raw=true)

### C. Seasonality: The Summer Spike
**Why this chart?** To see if marketing campaigns should be timed.
**Observation:**
Ridership for both groups peaks in July/August. However, Casual riders are "fair-weather" riders—their usage plummets in winter, whereas Members maintain a steady baseline of usage year-round.
![Seasonality](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Screenshot%202025-12-11%20034716.png?raw=true)

### D. Bike Type Preference
**Why this chart?** To see if equipment choice differs by user.
**Observation:**
Casual riders are the exclusive users of "Docked Bikes" and show a higher affinity for Electric Bikes on weekends compared to members.
![Bike Preference](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Screenshot%202025-12-11%20035321.png?raw=true)

### E. Geospatial Analysis: Hotspots
**Why this map?** To see "where" riders start their journeys.
**Observation:**
* **Casuals (Red/Orange):** Heavily clustered along the coastline, parks, and tourist attractions (Navy Pier, Millennium Park).
* **Members (Blue):** Distributed evenly across the city grid, near office buildings and residential hubs.
![Map](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Screenshot%202025-12-11%20040349.png?raw=true)



---

##  6. Act Phase
**Recommendations:**
Based on the analysis that Casual riders are **weekend-focused, leisure-oriented, and clustered near entertainment hubs**, I propose the following marketing strategies:

1.  **"Weekend Warrior" Membership:**
    * *Why:* Casuals spike on weekends.
    * *Action:* Create a membership tier specifically for Friday-Sunday usage to bridge the gap between single-rides and full annual commitments.

2.  **Geotargeted Advertising:**
    * *Why:* The Map visualization shows Casuals cluster at the coast.
    * *Action:* Place physical advertisements and QR codes at the top 10 coastal stations (e.g., Navy Pier) highlighting the savings of membership for longer rides.

3.  **Seasonal "Summer Pass" Campaign:**
    * *Why:* Seasonality chart shows usage peaks in July.
    * *Action:* Launch a limited-time "Summer Pass" in May/June. If users ride frequently during summer, offer them a discount to upgrade to an annual plan in the fall.

4.  **Duration-Based Incentives:**
    * *Why:* Casuals ride for 24+ minutes.
    * *Action:* Market the annual membership as a way to avoid "overage fees" on long leisure rides, positioning it as the "stress-free" way to explore the city.
    
---

 ### E. Some more viz made on Rstudio (ggplot)
 
   ![bar_chart_to_show_weekly_trends](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Untitled%20picture.png?raw=true)
    ![bar_charts](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Untitled%20picture1.png?raw=true)
    
   * **finding:**  Casual riders peak on weekends.

   ---
   ![Distribution of riders](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Untitled%20pie.png?raw=true)
    ![pie_distribution](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Untitled%20picture_pie.png?raw=true)
    
   * **finding:**  there are 60% membership riders and 40% casual riders on whom we need to focus for future ad campaign.
     ---
   ![yearly_trends](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Untitled%20line.png?raw=true)
    ![yearly_trends_summerpeak](https://github.com/rachit-malik/Cyclistic-Capstone-Project/blob/main/viz/Untitled%20picture_line.png?raw=true)
    
   * **finding:** bikes riding peek in summer months around `May start - July end`, the time best for campaiging is the start of summer time.

---
*Author: Rachit Malik *Date: December 11, 2025*
