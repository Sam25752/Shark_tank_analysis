SELECT TOP 10 *
FROM dbo.SharkTankPitches;

select count(*)
from SharkTankPitches;

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SharkTankPitches'
ORDER BY ORDINAL_POSITION;


select [Season Number], [Startup Name]
from SharkTankPitches
where [Startup Name]='Kyari';

--checking nulls

SELECT
    COUNT(*) AS Total_Pitches,
    SUM(CASE WHEN [Startup Name] IS NULL THEN 1 ELSE 0 END) AS Missing_Startup_Name,
    SUM(CASE WHEN Industry IS NULL THEN 1 ELSE 0 END) AS Missing_Industry,
    SUM(CASE WHEN [Total Deal Amount] IS NULL THEN 1 ELSE 0 END) AS Missing_Deal_Amount
FROM SharkTankPitches
WHERE [Season Number] = 1;

-- per season count

SELECT
    [Season Number],
    COUNT(*) AS Total_Pitches
FROM SharkTankPitches
GROUP BY [Season Number]
ORDER BY [Season Number];


--How many total pitches were made in Season 1?
select count(*)
from SharkTankPitches
where [Season Number]=1;

--How many unique startups pitched?
select count(distinct [Startup Name])
from SharkTankPitches
where [Season Number]=1;



--How many different industries are represented?

SELECT
    Industry,
    COUNT(*) AS Total_Pitches
FROM SharkTankPitches
WHERE [Season Number] = 1
GROUP BY Industry
ORDER BY Total_Pitches DESC;


--What percentage of all pitches came from each industry?
select [Industry] ,cast ((count(*)*100.0/152) as decimal(10,2)) as cnt
from SharkTankPitches
WHERE [Season Number] = 1
GROUP by [Industry]
ORDER BY cnt desc; 

--How many pitches were made by solo founders versus teams, if founder-count data is available?
select count(*)
from SharkTankPitches
where [Number of Presenters]=1 and [Season Number]=1;



--how many companies received offer
SELECT
    [Received Offer],
    COUNT(*) AS Total_Pitches
FROM SharkTankPitches
WHERE [Season Number] = 1
GROUP BY [Received Offer];


--how many companies accepted the offer?
SELECT
    [Accepted Offer],
    COUNT(*) AS Total_Pitches
FROM SharkTankPitches
WHERE [Season Number] = 1
GROUP BY [Accepted Offer];

--what was overall success rate and perecntage of pitches didn't received any offer ?
select count(*) as total_pitches,
round(sum(
    case when [Accepted Offer]=1 then 1
    else 0 end
)*100.0/count(*),2) as success_rate,
round(sum(
    case when [Received Offer]=0 then 1
    else 0 end
)*100.0/count(*),2) as companies_without_offer
from SharkTankPitches
where [Season Number]=1;


--Which industries had the highest number of successful deals?
select industry,
sum([Accepted Offer]) as successful_deals,
cast(sum([Accepted Offer])*100.0/count(*) as decimal(10,2)) as successful_industry_rate
from SharkTankPitches
WHERE [Season Number] = 1
group by Industry
order by successful_deals desc;


-- How does the deal success rate vary by episode?
select [Episode Number],
sum([Accepted Offer])*100.0/count(*) as ep_success_rate
from SharkTankPitches
where [Season Number] = 1
group by [Episode Number];


--How many deals were made with multiple sharks
select count(*) as multi_shark_deals
from SharkTankPitches
where [Season Number]=1 
and [Number of Sharks in Deal]>1
and [Accepted Offer]=1;


-- What was the total investment amount offered across successful deals?
select sum([Total Deal Amount]) as total_invested_amount,
avg([Total Deal Amount]) as avg_deal_Amount
from SharkTankPitches
where [Season Number]=1 ;

-- highest and lowest deal?
select [Startup Name], [Total Deal Amount] as amount
from SharkTankPitches
where [Season Number]=1 and [Accepted Offer]=1
order by amount desc;


--avg investment amount by industry?
select [Industry], avg([Total Deal Amount]) as avg_invested,
sum([Total Deal Amount]) as total_invested
from SharkTankPitches
where [Season Number]=1 and [Accepted Offer]=1
group by [Industry];


-- Are investment amounts heavily skewed by a few large deals?
WITH SeasonStats AS (
    SELECT 
        [Total Deal Amount],
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY [Total Deal Amount]) OVER () AS MedianAmount
    FROM SharkTankPitches
    WHERE [Season Number] = 1 AND [Accepted Offer] = 1
)
SELECT 
    COUNT(*) AS TotalDeals,
    AVG(CAST([Total Deal Amount] AS FLOAT)) AS MeanAmount,
    MAX(MedianAmount) AS MedianAmount,
    MAX([Total Deal Amount]) AS LargestDeal,
    MIN([Total Deal Amount]) AS SmallestDeal
FROM SeasonStats;


-- What was the average and median equity percentage offered by entrepreneurs?
with cte as (
    select [Total Deal Equity],
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY [Total Deal Equity]) OVER () AS MedianAmount
    FROM SharkTankPitches
    WHERE [Season Number] = 1 AND [Accepted Offer] = 1
)
select AVG(CAST([Total Deal Equity] AS FLOAT)) AS meanequity,
max(MedianAmount) medianequity
FROM cte;


select [Startup Name],
[Total Deal Equity]
FROM SharkTankPitches
WHERE [Season Number] = 1 AND [Accepted Offer] = 1
order by [Total Deal Equity] desc;


-- How do implied valuations vary across industries?
select [Industry], avg([Total Deal Equity]) as avg_equity
from SharkTankPitches
where [Season Number]=1 and [Accepted Offer]=1
group by [Industry]
order by avg_equity desc;


-- How often did sharks invest at the exact amount requested by entrepreneurs (this does not signify valuation)
select [Startup Name], [Original Ask Amount], [Total Deal Amount]
from SharkTankPitches
where [Season Number]=1 and [Original Ask Amount]=[Total Deal Amount] and [Accepted Offer]=1;


-- Which startups asked for the highest investment amount?
select top 1 [Startup Name], [Original Ask Amount] 
from SharkTankPitches
where [Season Number]=1 
order by [Original Ask Amount] desc ;

-- Which startups received substantially more or less than their requested amount? (this does not signify valuation)
select [Startup Name] , [Original Ask Amount], [Total Deal Amount]
from SharkTankPitches
where [Season Number]=1 and [Original Ask Amount]!=[Total Deal Amount];


-- Does the number of founders differ between startups that received deals and those that did not?
select [Received Offer] , avg([Number Of Presenters]) avg_presenters, count(*) as total_count
from SharkTankPitches
where [Season Number]=1
GROUP BY [Received Offer];


-- Do startups with higher requested valuations have different deal success rates?
select cast(sum(
    case when [Accepted Offer]=1 then 1 else 0 end
)*100.0/ count(*) as decimal (10,2))  as success_rate
from SharkTankPitches
where [Season Number]=1 and [Valuation Requested]>100;


-- Which startups received deals despite asking for relatively high equity?
select [Startup Name], [Original Offered Equity], [Total Deal Equity]
from SharkTankPitches
where [Season Number]=1 and [Received Offer]=1 and [Original Offered Equity]>=25;

-- Which startups received no deal despite asking for relatively low equity?
select [Startup Name] , [Original Offered Equity], [Received Offer]
from SharkTankPitches
where [Season Number]=1 and [Original Offered Equity]<=1 and [Received Offer]=0;


-- How many deals did each shark participate in?
select 'Namita' as Shark,count([Namita Investment Amount]) as Number_of_investment,
Sum([Namita Investment Amount]) as total_investment,
Sum([Namita Investment Amount])/count([Namita Investment Amount]) as avg_investment
from SharkTankPitches
where [Season Number]=1

UNION

select 'Vineeta', count([Vineeta Investment Amount]), Sum([Vineeta Investment Amount]),
Sum([Vineeta Investment Amount])/count([Vineeta Investment Amount])
from SharkTankPitches
where [Season Number]=1

UNION 

select 'Anupam', count([Anupam Investment Amount]), Sum([Anupam Investment Amount]),
Sum([Anupam Investment Amount])/count([Anupam Investment Amount])
from SharkTankPitches
where [Season Number]=1

UNION 

select 'Aman', count([Aman Investment Amount]), Sum([Aman Investment Amount]),
Sum([Aman Investment Amount])/count([Aman Investment Amount])
from SharkTankPitches
where [Season Number]=1

UNION 

select 'Peyush', count([Peyush Investment Amount]), Sum([Peyush Investment Amount]),
Sum([Peyush Investment Amount])/count([Peyush Investment Amount])
from SharkTankPitches
where [Season Number]=1

UNION 

select [Invested Guest Name], count([Guest Investment Amount]), Sum([Guest Investment Amount]),
Sum([Guest Investment Amount])/count([Guest Investment Amount])
from SharkTankPitches
where [Season Number]=1 and [Invested Guest Name] is not null
group by [Invested Guest Name];



-- Which industries did individual sharks invest in most frequently?
WITH CombinedSharks AS (
    SELECT 'Namita' AS Shark, Industry FROM SharkTankPitches WHERE [Season Number] = 1 AND [Namita Investment Amount] IS NOT NULL
    UNION ALL
    SELECT 'Vineeta', Industry FROM SharkTankPitches WHERE [Season Number] = 1 AND [Vineeta Investment Amount] IS NOT NULL
    UNION ALL
    SELECT 'Anupam', Industry FROM SharkTankPitches WHERE [Season Number] = 1 AND [Anupam Investment Amount] IS NOT NULL
    UNION ALL
    SELECT 'Aman', Industry FROM SharkTankPitches WHERE [Season Number] = 1 AND [Aman Investment Amount] IS NOT NULL
    UNION ALL
    SELECT 'Peyush', Industry FROM SharkTankPitches WHERE [Season Number] = 1 AND [Peyush Investment Amount] IS NOT NULL
),
RankedIndustries AS (
    SELECT 
        Shark,
        Industry,
        COUNT(*) AS Deals_Count,
        DENSE_RANK() OVER (PARTITION BY Shark ORDER BY COUNT(*) DESC) AS IndustryRank
    FROM CombinedSharks
    GROUP BY Shark, Industry
)
SELECT 
    Shark, 
    Industry, 
    Deals_Count
FROM RankedIndustries
WHERE IndustryRank = 1;

-- Which industries attracted the most combined shark participation?
SELECT  [Industry], count(*) as number_of_deals
from SharkTankPitches
where [Season Number]=1 and [Number of Sharks in Deal]>1 and [Accepted Offer]=1
group by [Industry]
ORDER by number_of_deals desc;


-- How much did the final equity percentage differ from the equity requested?
select [Startup Name],[Total Deal Equity],[Original Offered Equity] , [Total Deal Equity]-[Original Offered Equity] as euity_difference
from SharkTankPitches
where [Season Number]=1 and [Accepted Offer]=1;


-- What was the average change in implied valuation between the requested and final deal terms?
select [Startup Name] ,[Deal Valuation], [Valuation Requested], [Valuation Requested]-[Deal Valuation] as diff
from SharkTankPitches
where [Season Number]=1 and [Accepted Offer]=1;


--  Which industries showed the largest differences between requested and agreed deal terms?
select [Industry] , sum([Valuation Requested]-[Deal Valuation]) total_diff,avg([Valuation Requested]-[Deal Valuation]) as avg_diff
from SharkTankPitches
where [Season Number]=1 and [Accepted Offer]=1
group by [Industry];


-- How many pitches and deals occurred in each episode?
select [Episode Number], count(*) as number_of_pitches, sum([Accepted Offer]) as accepted_offers,
cast(sum(
    case when [Accepted Offer]=1 then 1 else 0 end
)*100.0/nullif(count(*),0) as decimal (10,2)) as success_rate,
cast(sum([Total Deal Amount]) as decimal (10,2)) totql_deal_amount,
cast(avg([Total Deal Amount]) as decimal (10,2)) avg_deal_amount
from SharkTankPitches
where [Season Number]=1
group by [Episode Number];


-- Did the types of industries pitched vary across episodes?
select [Industry], [Episode Number], count(*) ep_wise_industries
from SharkTankPitches
where [Season Number]=1 
group by [Industry], [Episode Number];


--Which pitches have unusually high investment amounts? (>1cr)
select [Startup Name], [Total Deal Amount], [Total Deal Equity]
from SharkTankPitches
where [Season Number]=1 and ([Total Deal Amount]>100 or [Total Deal Equity]>15);


-- Are certain industries associated with larger deal amounts after considering the number of successful deals?
select [Startup Name],[Industry], [Total Deal Amount], [Total Deal Equity]
from SharkTankPitches
where [Season Number]=1 and [Total Deal Amount]>100 and [Accepted Offer]=1;


-- Which industries combine high pitch volume, high deal success rates, and high total investment?
select [Industry], count(*) no_of_pitches, 
cast(sum(case when [Accepted Offer]=1 then 1 else 0 end) * 100.0/ count(*) as decimal(10,2)) deal_success_rate,
sum([Total Deal Amount]) as total_deal_amount,
avg([Total Deal Amount]) as avg_deal_amount
from SharkTankPitches
where [Season Number]=1
group by [Industry]
order by no_of_pitches desc, deal_success_rate desc , total_deal_amount desc;



-- Which three industries stood out in Season 1, and why?
select [Industry], [Season Number], count(*)
from SharkTankPitches
group by [Industry], [Season Number]
having count(*)=0;


--Which industries had high pitch volume but relatively low deal success? (business services)
select [Industry], count(*) as pitch_volume, 
cast (sum([Accepted Offer])*100.0/count(*) as decimal (10,2)) as success_rate
from SharkTankPitches
where [Season Number]=1
group by [Industry]
order by pitch_volume desc, success_rate asc;