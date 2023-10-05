-- 1) Write a query to get the sum of impressions by day.

SELECT EXTRACT(DOW FROM date) AS day_of_week,
    SUM(impressions) AS total_impressions
FROM marketing_performance
GROUP BY day_of_week
ORDER BY day_of_week


  
-- 2) Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?

SELECT state, SUM(revenue) AS total_revenue 
FROM website_revenue
GROUP BY state
ORDER BY total_revenue DESC 
LIMIT 3

-- The state with the third best revenue is Ohio(OH) with $37,577

  
-- 3) Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.

SELECT c.id,c.name, SUM(cost) AS total_cost,
	SUM(impressions) AS total_impressions, 
	SUM(clicks) AS total_clicks,
	SUM(w.revenue) AS total_revenue 
FROM marketing_performance m
JOIN campaign_info c
ON m.campaign_id = CAST(c.id AS varchar)
JOIN website_revenue w
ON w.campaign_id = CAST(c.id AS varchar)
Group by c.id
Order by c.name

  
-- 4) Write a query to get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?

SELECT c.name, w.state, SUM(m.conversions) AS total_conversions
FROM marketing_performance m
JOIN campaign_info c
ON m.campaign_id = CAST(c.id AS varchar)
JOIN website_revenue w
ON w.campaign_id = CAST(c.id AS varchar)
WHERE c.name = 'Campaign5'
GROUP BY w.state,c.name 
order by total_conversions DESC
  
-- the state with the most no of conversions from campaign5 is Georgia (GA)

  
-- 5) In your opinion, which campaign was the most efficient, and why?
  
SELECT c.id,name, SUM(cost) AS total_cost,
	SUM(impressions) AS total_impressions, 
	SUM(clicks) AS total_clicks,
	SUM(revenue) AS total_revenue,
	SUM(revenue)-SUM(cost) AS profit,
	(((SUM(revenue)-SUM(cost))/SUM(cost))*100) AS ROI
FROM marketing_performance m
JOIN campaign_info c
ON m.campaign_id = CAST(c.id AS varchar)
JOIN website_revenue w
ON w.campaign_id = CAST(c.id AS varchar)
Group by c.id
Order by c.name

-- The most efficent campaign is campaign 4 because they had the least amount of investment but had the highest ROI amongst
-- all the  other campaigns

  
--Bonus Question

-- 6) Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.
  
SELECT EXTRACT(DOW FROM date) AS day_of_week,
    SUM(impressions) AS total_impressions,
	SUM(clicks) AS total_clicks,
	SUM(conversions) AS total_conversions
FROM marketing_performance
GROUP BY day_of_week
ORDER BY day_of_week

-- Friday is the best day of the week to run ads. Friday has the highes no of impressions, clicks and conversions 
-- compared to all the other days

