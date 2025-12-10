# Google Data Analytics Capstone: Cyclistic Case Study 🚴‍♀️

## 📖 Introduction
This is my Capstone project for the **Google Data Analytics Professional Certificate**. 

**Scenario:** I am a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. 

**Objective:** Design marketing strategies aimed at converting casual riders into annual members.

---

## ❓ 1. Ask
**Business Task:**
Analyze historical bike trip data to identify trends in how annual members and casual riders use Cyclistic bikes differently.

**Stakeholders:**
* **Lily Moreno:** Director of Marketing.
* **Cyclistic Executive Team:** Detail-oriented executive team.

---

## 💾 2. Prepare
**Data Source:**
I used the previous 12 months of Cyclistic trip data (public data provided by Motivate International Inc.).
* [Link to Original Dataset](https://divvy-tripdata.s3.amazonaws.com/index.html)
* *Note:* Data-privacy issues prohibit using riders’ personally identifiable information.

---

## 🛠 3. Process
**Tools Used:**
1.  **R Studio:** For data cleaning, transformation, and validation.
2.  **Power BI:** For creating interactive visualizations and geospatial analysis.

**Data Cleaning Steps (R Studio):**
* Consolidated 12 CSV files into a single dataframe.
* Standardized column names and removed duplicates.
* Created new columns: `ride_length`, `day_of_week`, `month`.
* Filtered out data anomalies (rides < 1 minute or > 24 hours).


*The full R analysis script is available in this repository as `Cyclistic Bike-Share Analysis Capstone`.*

---

## 📊 4. Analyze & Share
I exported the cleaned data to **Power BI** to create the following visualizations.

### A. Weekly Riding Habits
**Insight:** Members (Dark Blue) use bikes for commuting (Mon-Fri), while Casual riders (Light Blue) spike significantly on weekends.
![Weekly Habits](visualizations/Screenshot 2025-12-11 034152.png)

### B. Ride Duration
**Insight:** Casual riders take trips that are nearly **2x longer** than members. Members prioritize speed/efficiency (A to B), while Casuals prioritize leisure.
![Ride Duration](visualizations/Screenshot 2025-12-11 034353.png)

### C. Seasonality
**Insight:** Both groups peak in Summer (July/Aug). However, Casual ridership drops near zero in Winter, whereas Members maintain a steady baseline.
![Seasonality](visualizations/Screenshot 2025-12-11 034716.png)

### D. Bike Preference
**Insight:** Casual riders are the primary users of "Docked Bikes" and show a strong preference for Electric bikes on weekends.
![Bike Preference](visualizations/Screenshot 2025-12-11 035321.png)

### E. Detailed Variance
**Insight:** An area chart highlights how Member usage is stable, while Casual usage is highly volatile based on the day.
![Variance](visualizations/Screenshot 2025-12-11 035048.png)

### F. Geospatial Analysis
**Insight:** * **Casuals:** Cluster around the coastline and parks (tourism spots).
* **Members:** Scattered throughout the city grid (office/residential areas).
![Map](visualizations/Screenshot 2025-12-11 040349.jpg)

---

## 💡 5. Act (Recommendations)
Based on the analysis, I recommend the following marketing strategies:

1.  **"Weekend Warrior" Membership:** Create a membership tier specifically for weekends, bridging the gap for casual riders who only ride Sat/Sun.
2.  **Location-Based Ads:** Place physical advertisements at the docking stations near the coastline and parks (identified in the Map visualization).
3.  **Summer Campaign:** Launch the main marketing push in **May/June**, just before the seasonal spike in casual ridership.
4.  **Duration Incentives:** Offer discounts for rides over 20 minutes to annual members, appealing to the casual rider's habit of taking longer trips.

---
*Author: Rachit Malik*
