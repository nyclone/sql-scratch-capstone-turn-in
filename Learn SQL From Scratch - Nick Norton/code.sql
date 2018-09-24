--The number of distinct campaigns
SELECT COUNT(DISTINCT utm_campaign) AS 'Campaign Count'
FROM page_visits;

-- The number of distinct sources
SELECT COUNT(DISTINCT utm_source) AS 'Source Count'
FROM page_visits;

--How they are related
SELECT DISTINCT utm_campaign AS 'Campaign', utm_source AS 'Source'
FROM page_visits;




--What pages are on the CoolTShirts website?
SELECT DISTINCT page_name AS 'Pages'
FROM page_visits;




--How many first touches is each campaign responsible for?
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id),
    
ft_at AS (
  SELECT ft.user_id,
   			 ft.first_touch_at,
  		 	 pv.utm_source,
				 pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
         )
SELECT ft_at.utm_campaign AS 'Campaign',
			 COUNT(*) AS 'First Touch'
FROM ft_at
GROUP BY 1
ORDER BY 2 DESC;





--How many last touches is each campaign responsible for?
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) AS last_touch_at
    FROM page_visits
    GROUP BY user_id),
    
lt_at AS (
  SELECT lt.user_id,
   			 lt.last_touch_at,
  		 	 pv.utm_source,
				 pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
         )
SELECT lt_at.utm_campaign AS 'Campaign',
			 COUNT(*) AS 'Last Touch'
FROM lt_at
GROUP BY 1
ORDER BY 2 DESC;




--How many visitors make a purchase?
SELECT COUNT(DISTINCT(user_id)) AS 'purchases'
FROM page_visits
WHERE page_name = '4 - purchase';


--How many visitors make a purchase?
SELECT COUNT(user_id) AS 'purchases'
FROM page_visits
WHERE page_name = '4 - purchase';




--How many last touches on the purchase page is each campaign responsible for?
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) AS last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id),

lt_at AS (
  SELECT lt.user_id,
   			 lt.last_touch_at,
  		 	 pv.utm_source,
				 pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
         )
SELECT lt_at.utm_campaign AS 'Campaign',
			 COUNT(*) AS 'Last Touch'
FROM lt_at
GROUP BY 1
ORDER BY 2 DESC;




--Last Touch 4 - Purchse by Source and Campaign
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) AS last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id),

lt_at AS (
  SELECT lt.user_id,
   			 lt.last_touch_at,
  		 	 pv.utm_source,
				 pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
         )
                  
SELECT lt_at.utm_campaign AS 'Campaign',
			 lt_at.utm_source AS 'Source',
			 COUNT(*) AS 'Purchase'
FROM lt_at
GROUP BY 1, 2
ORDER BY 3 DESC;


--Last Touch by Source and Campaign
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) AS last_touch_at
    FROM page_visits
    GROUP BY user_id),

lt_at AS (
  SELECT lt.user_id,
   			 lt.last_touch_at,
  		 	 pv.utm_source,
				 pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
         )
                  
SELECT lt_at.utm_campaign AS 'Campaign',
			 lt_at.utm_source AS 'Source',
			 COUNT(*) AS 'Last Touch'
FROM lt_at
GROUP BY 1, 2
ORDER BY 3 DESC;


--First Touch by Source and Campaign
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) AS first_touch_at
    FROM page_visits
    GROUP BY user_id),

ft_at AS (
  SELECT ft.user_id,
   			 ft.first_touch_at,
  		 	 pv.utm_source,
				 pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
         )
                  
SELECT ft_at.utm_campaign AS 'Campaign',
			 ft_at.utm_source AS 'Source',
			 COUNT(*) AS 'First Touch'
FROM ft_at
GROUP BY 1, 2
ORDER BY 3 DESC;


--Customer Journey
SELECT page_name AS 'Page Name',
			 COUNT(DISTINCT user_id) 'Page View'
FROM page_visits
GROUP BY page_name;