WITH facebook_data AS (
  SELECT f.ad_date, f.spend, f.impressions, f.reach, f.clicks, f.leads, f.value, f.campaign_id
  FROM facebook_ads_basic_daily f 
),
google_data AS (
  SELECT g.ad_date, g.campaign_name, g.spend, g.impressions, g.reach, g.clicks, g.leads, g.value
  FROM Google_ads_basic_daily g 
  UNION
  SELECT f.ad_date, c.campaign_name, f.spend, f.impressions, f.reach, f.clicks, f.leads, f.value
  FROM facebook_ads_basic_daily f
  JOIN facebook_adset a ON f.adset_id = a.adset_id
  JOIN facebook_campaign c ON f.campaign_id = c.campaign_id 
)
SELECT ad_date, campaign_name, SUM(spend) AS total_spend, SUM(impressions) AS total_impressions, SUM(reach) AS total_reach, SUM(clicks) AS total_clicks, SUM(leads) AS total_leads, SUM(value) AS total_value
FROM google_data
GROUP BY ad_date, campaign_name
ORDER BY ad_date, campaign_name;
