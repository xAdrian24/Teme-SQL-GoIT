select ad_date, campaign_id,  
sum(spend) cost_total, 
sum(impressions) nr_impresii, 
sum(clicks) nr_clickuri, 
sum(value) valoarea_totala_a_conversiei, 
sum(spend)/sum(clicks) as "CPC", 
sum(spend)/sum(impressions)*1000 as "CPM", 
(sum(clicks)::numeric /sum(impressions))*100 as "CTR",
((SUM(value)::numeric  - SUM(spend)) / nullif(SUM(spend),0))*100 as "ROMI",
(sum(value)::numeric - sum(spend))/sum(spend)*100 as "romi2",
cast(SUM(value) - SUM(spend)as numeric)/ nullif(SUM(spend),0)*100  as "Romi3" 
from facebook_ads_basic_daily 
where  clicks > 0 
group by ad_date, campaign_id      
