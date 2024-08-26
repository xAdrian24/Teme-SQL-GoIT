select 
ad_date, spend, clicks, div(spend,clicks) raport
from facebook_ads_basic_daily
where clicks > 0
order by 
ad_date desc 
