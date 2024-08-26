--Sarcina 1
select 
event_timestamp,
user_pseudo_id,
(select value.int_value from e.event_params where key ='ga_sesion_id') as sesion_id,
event_name,
geo.country as country,
device.category as device_category,
traffic_source.source as source,
traffic_source.medium as medium,
traffic_source.name as campaign
from 
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` e
where event_name in ('session_start','view_item','add_to_cart','begin_checkout','add_shipping_info','add_payment_info','purchase')
limit 1000;
--Sfarsit Sarcina 1

--Sarcian 2 
SELECT
  DATE(TIMESTAMP_MICROS(event_timestamp)) AS event_date,
  traffic_source.source AS source,
  traffic_source.medium AS medium,
  traffic_source.name AS campaign,
  COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS user_sessions_count,
  SUM(IF(event_name = 'add_to_cart', 1, 0)) AS visit_to_cart,
  SUM(IF(event_name = 'begin_checkout', 1, 0)) AS visit_to_checkout,
  SUM(IF(event_name = 'purchase', 1, 0)) AS visit_to_purchase
FROM
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY
  event_date,
  source,
  medium,
  campaign
--Sfarsit Sarcina 2
  
--Sarcian 3
WITH Params AS (
  SELECT
    user_id,
    user_pseudo_id,
    (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_location') AS page_location
  FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE
    _TABLE_SUFFIX = '2020'
),
SessionStarts AS (
  SELECT
    user_id,
    user_pseudo_id,  
    REGEXP_EXTRACT(page_location, r'^(?:https?:\/\/)?(?:[^@\/\n]+@)?(?:www\.)?([^:\/\n]+)') AS domain,
    REGEXP_EXTRACT(page_location, r'([^?#]*)') AS page_path,
    COUNT(1) OVER (PARTITION BY user_id, page_location) AS unique_sessions_per_user   
  FROM
    Params
),
Purchases AS (
  SELECT
    user_id,
    user_pseudo_id,    
    COUNT(1) AS purchases
  FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE
    event_name = 'purchase'
    AND _table_suffix = '2020'
  GROUP BY
    user_id,
    user_pseudo_id
),
ConversionRates AS (
  SELECT
    s.user_id,
    s.page_path,
    COUNT(p.user_pseudo_id) AS conversions
  FROM
    SessionStarts s
  LEFT JOIN
    Purchases p
  ON
    s.user_id = p.user_id
    AND s.user_pseudo_id = p.user_pseudo_id
  GROUP BY
    s.user_id,
    s.page_path
)
SELECT
  s.page_path,
  COUNT(DISTINCT s.user_id) AS unique_users,
  SUM(p.purchases) AS total_purchases,
  IFNULL(SUM(c.conversions), 0) / COUNT(DISTINCT s.user_id) AS session_to_purchase_conversion
FROM
  SessionStarts s
LEFT JOIN
  Purchases p
ON
  s.user_id = p.user_id
  AND s.user_pseudo_id = p.user_pseudo_id
LEFT JOIN
  ConversionRates c
ON
  s.user_id = c.user_id
  AND s.page_path = c.page_path
GROUP BY
  s.page_path
--Sfarsit Sarcina 3

