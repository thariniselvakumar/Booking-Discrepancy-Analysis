**Project Overview :**

You are provided with a raw dataset containing booking information for a multi-service business. This dataset includes a mix of class bookings, subscriptions, facility rentals, and birthday party reservations. The dataset reflects a real-world export and may contain imperfections, inconsistencies, or incomplete data.

**Dataset** : 

https://github.com/thariniselvakumar/Booking-Discrepancy-Analysis/blob/main/booking%20dataset.xlsx 


**Objective:** 

This project involves a comprehensive analysis of a given dataset, commencing with data cleaning and preprocessing using Python. Exploratory Data Analysis (EDA) and business queries will be performed using SQL. Key findings will be visualized using Power BI, providing actionable insights.

## Data Pre-processing using Python:

Code : https://github.com/thariniselvakumar/Booking-Discrepancy-Analysis/blob/main/booking_python_code.ipynb

```python
# Importing required libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Loading the dataset 
df = pd.read_excel('OneDrive/DataAnalyst_Assesment_Dataset.xlsx')
df.head()

# Data Cleaning 
# 1- Removing subscription column _ no values
df.drop(columns= ['Subscription Type'],inplace = True)

# 2-Finding missing values 
df.isnull().sum()

# 3-Handling missing values 
# unknown/missing for categorical
# Mode /median for numerical
df['Class Type']=df['Class Type'].fillna("Unknown" )
df['Instructor']=df['Instructor'].fillna("Unknown")
df['Time Slot']=df['Time Slot'].fillna(df['Time Slot'].mode()[0]) #Fills the most common time
df['Duration (mins)'] = df['Duration (mins)'].fillna(df['Duration (mins)'].median()) # fills with median
df['Facility']=df['Facility'].fillna("Unknown")
df['Theme']=df['Theme'].fillna("Unknown")
df['Customer Email']=df['Customer Email'].fillna("Missing")
df['Customer Phone']=df['Customer Phone'].fillna("Missing")

# 4 - changing Time slot to proper format 
df['Time Slot'] = pd.to_datetime(df['Time Slot'], format = '%H:%M:%S').dt.time

# 5 - Duplicate Booking-Ids
df.drop_duplicates(subset = ['Booking ID'],inplace =True)

# 6 - Standardize Text Formatting 
textcol =['Customer Name', 'Booking Type', 'Status', 'Class Type', 'Facility', 'Theme', 'Service Name', 'Service Type']
for col in textcol:
    df[col] =df[col].astype(str).str.strip().str.lower()
    
# 7 - Checking Outliers for Price column
sns.boxplot(df)
plt.show()  #no outliers found

# 8 - Email format checking 
df = df[df['Customer Email'].str.match(r'[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$') | (df['Customer Email'] == "Missing")]

#Final step - Cleaned dataset
df.to_excel('OneDrive/DataAnalyst_Assesment_Dataset.xlsx', index= False)
df.info(), df.head()
```

**Key Points :**

- Removed **subscription** column (100% missing values)
- Handled **missing** values both in categorical and numerical columns
- Checked proper **time format**
- Checked for **duplicates**
- Standardize **Text Formatting**
- Detecting for **Outliers**
- Checked for **Email formatting**

Cleaned Dataset : 

https://github.com/thariniselvakumar/Booking-Discrepancy-Analysis/blob/main/booking%20data_cleaned.xlsx

**EDA in SQL Server:**

code: https://github.com/thariniselvakumar/Booking-Discrepancy-Analysis/blob/main/SQl%20code_project.sql

```sql
--Importing the Dataset
USE PROJECT;

--Table Creation and imported data using flat file
SELECT * FROM Bookingdata;

--EDA Process:

--1--Summarizing Key statistics
SELECT COUNT(*) AS Total_Bookings, COUNT(DISTINCT Customer_ID) AS Unique_customers,
	AVG(Duration_mins) AS Avg_duration , 
	AVG(Price) AS Avg_price,
	MIN(Price) AS min_price,
	MAX(Price) AS max_price
FROM Bookingdata;

--2--Finding the status of the booking
SELECT COUNT(*) AS counts , status
FROM bookingdata
GROUP BY status 
ORDER BY counts;

--3--Revenue analysis by service type 
SELECT	Service_Type , COUNT(*) AS booking_count , SUM(Price) AS total_revenue, AVG(Price) AS avg_price
FROM Bookingdata
GROUP BY Service_Type
ORDER BY total_revenue;

--4--Customer Preferences
SELECT * FROM Bookingdata;
SELECT Booking_Type ,Class_Type, COUNT(*) AS Bookings 
FROM Bookingdata
GROUP BY Booking_Type , Class_Type
ORDER BY Bookings;

--5--Most popular time slots
SELECT Time_Slot, COUNT(*) as Booking_Count
FROM Bookingdata
GROUP BY Time_Slot
ORDER BY Booking_Count DESC;

--6--Instructor analysis 
SELECT Instructor , COUNT(*) AS bookings, SUM(Price) AS revenue
FROM Bookingdata
WHERE Instructor != 'Unknown'
GROUP BY Instructor
ORDER BY bookings;

--7--Booking trend over time
SELECT FORMAT(Booking_Date, 'yyyy-MM') AS Booking_Month, COUNT(*) AS Total_Bookings
FROM Bookingdata
GROUP BY FORMAT(Booking_Date, 'yyyy-MM')
ORDER BY Booking_Month DESC;

--8--Services analysis
SELECT Service_Name , Service_Type , COUNT(*) AS bookings , SUM(Price) AS revenue
FROM Bookingdata
GROUP BY Service_Name,Service_Type
ORDER BY bookings DESC, revenue DESC;

```

**Key Findings /Recommendations:**

- Helps identify **high-demand periods** to optimize pricing or promotions
- Discounts of the preferred timeslots
- If **Birthday Parties** are most booked, offer **premium packages** to boost revenue
- If **Facility** bookings are low, consider targeted marketing campaigns
- Targeted campaigns according to the **service type**

These SQL queries provide comprehensive insights into various aspects of the business including booking patterns, revenue analysis, resource utilization, and customer preferences.

**Power BI Report :**

**Overview** : This Power BI report provides a comprehensive analysis of the bookings, offering actionable insights and recommendations. Through interactive visuals and dashboards, the report highlights key trends, patterns, and correlations, enabling stakeholders to make informed decisions. The report's findings and recommendations aim to [specific goal or objective], driving business growth and improvement.

*Report : https://github.com/thariniselvakumar/Booking-Discrepancy-Analysis/blob/main/powerbi_booking_report.pbix
**Insights :**

- The business has generated 39.48K in revenue from 1000 bookings, indicating an average revenue per booking of approximately $39.48
- The business generates consistent revenue from a few high-demand services
- A handful of customers contribute significantly to total revenue.

**Recommendations:**

- Focus marketing efforts on these popular services to attract more customers
- Increase the price for premium services to boost per-booking revenue
- Reduce pending bookings through automated confirmations
- Expand marketing efforts for underperforming services

---

---
