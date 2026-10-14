# Shark Tank India Season 1 — Exploratory Data Analysis (EDA)

> **Project status:** completed 
> **Analysis tool:** Microsoft SQL Server (MSSQL)  
> **Main table:** `SharkTankPitches`  
> **Season covered:** Season 1 only

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Business Objectives](#2-business-objectives)
3. [Key Questions](#3-key-questions)
4. [Dataset Overview](#4-dataset-overview)
5. [Tools and Technologies](#5-tools-and-technologies)
6. [Future Improvements](#6-future-improvements)
7. [Author](#7-author)

---

## 1. Project Overview

This project explores pitches made during **Season 1 of Shark Tank India** using SQL Server. The aim is to understand which startups pitched, which industries were represented, how often pitches resulted in deals, how investment and equity terms varied, and how sharks participated in the deals.

The analysis uses exploratory data analysis (EDA) to identify patterns, compare groups, investigate unusual values, and turn query results into clear business observations.

**Important:** This project describes patterns in the available dataset. It does not assume that an observed relationship proves causation.

### Project summary

| Item               |            Details                       |
|--------------------|------------------------------------------|
| Project name       |   Shark Tank India Season 1 EDA          |
| Business domain    |   Startups, entrepreneurship, investment |
| Analysis type      |   Exploratory Data Analysis              |
| SQL environment    |   Microsoft SQL Server                   |
| Table name         |  `SharkTankPitches`                      |
| Season scope       |   Season 1                               |

---

## 2. Business Objectives

The main objectives of this analysis are to:

- Understand the structure, completeness, and reliability of the dataset.
- Measure the number of pitches and their distribution across industries.
- Explore pitch outcomes and calculate the deal success rate.
- Analyse investment amounts, equity percentages, and implied valuations where the required fields are available.
- Compare investment activity across sharks and episodes where the dataset supports these comparisons.
- Summarise evidence-backed findings about Season 1.

---

## 3. Key Questions

The project is organised around the following business questions. 

### 3.1 Overall pitch analysis

- How many pitches and unique startups are represented?
- How many industries are present?
- Which industries had the most pitches?
- What share of pitches came from each industry?

### 3.2 Deal outcomes

- How many pitches received a deal versus no deal?
- What was the overall deal success rate?
- How did deal success vary by industry and episode?

### 3.3 Investment and equity

- What were the total, and average deal amounts?
- Which startups received the largest deals?
- How did investment amounts vary across industries?
- What equity percentages did entrepreneurs offer and agree to?

### 3.4 Shark participation

- Which sharks participated in the most deals?
- Which industries attracted the most shark participation?
- How often did multiple sharks participate in the same deal?
- How individual shark investment varied?

### 3.5 Episode trends and deeper analysis

- How did pitch counts, deal counts, and investment totals vary by episode?
- Which values appear unusually high or low?
- Were there differences in outcomes across industries or other available groups?

---

## 4. Dataset Overview

### 4.1 Source

- **Dataset name:** Shark Tank India
- **Source / download URL:** "Shark Tank India.csv"
- **File used for loading:** "Shark Tank India.csv"
- **Database:** Microsoft SQL Server
- **Table:** `SharkTankPitches`
- **Season filter:** Season 1


### 4.2 Dataset grain

**What does one row represent?**
Here one Row represent one Pitch by Startup.

### 4.3 Dataset size

| Metric               | Result   |
|----------------------|----------|
| Total rows loaded    | 152      |
| Total columns        | 80       |
| Unique startups      | 152      |
| Season               | Season 1 |
| Duplicate rows found | 0        |

### 4.4 Important columns

COLUMN_NAME                DATA_TYPE   IS_NULLABLE
-------------------------  ----------  -----------
Season Number              int         YES        
Startup Name               varchar     YES        
Episode Number             int         YES               
Industry                   varchar     YES               
Number of Presenters       int         YES                              
Original Ask Amount        decimal     YES        
Original Offered Equity    decimal     YES        
Valuation Requested        decimal     YES        
Received Offer             int         YES        
Accepted Offer             int         YES        
Total Deal Amount          decimal     YES        
Total Deal Equity          decimal     YES        
Total Deal Debt            decimal     YES        
Debt Interest              decimal     YES        
Deal Valuation             float       YES        
Number of Sharks in Deal   int         YES              
Namita Investment Amount   decimal     YES        
Namita Investment Equity   decimal     YES        
Namita Debt Amount         decimal     YES        
Vineeta Investment Amount  decimal     YES        
Vineeta Investment Equity  decimal     YES        
Vineeta Debt Amount        decimal     YES        
Anupam Investment Amount   decimal     YES        
Anupam Investment Equity   decimal     YES        
Anupam Debt Amount         decimal     YES        
Aman Investment Amount     decimal     YES        
Aman Investment Equity     decimal     YES        
Aman Debt Amount           decimal     YES        
Peyush Investment Amount   decimal     YES        
Peyush Investment Equity   decimal     YES        
Peyush Debt Amount         decimal     YES                      
Guest Investment Amount    decimal     YES        
Guest Investment Equity    decimal     YES        
Guest Debt Amount          decimal     YES        
Invested Guest Name        varchar     YES        
All Guest Names            varchar     YES  

---

## 5. Tools and Technologies

- **Microsoft SQL Server:** Data querying and analysis.
- **SQL:** Filtering, aggregation, grouping, joins, conditional logic, and calculations.


## 6. Future Improvements


- Create a visual summary in Power BI or another visualisation tool.
- Compare Season 1 with later seasons using a consistent data model.
- Enrich the dataset with verified information on deal completion, if available.
- Analyse individual shark contributions.
- Add automated data-quality checks and reusable SQL views.

---

## 7. Author

**Name:** Samiksha Agarwal  
**Role / focus:** Data Analytics  


