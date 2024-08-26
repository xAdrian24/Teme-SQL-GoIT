select campaign_id, spend, cast(SUM(value) - SUM(spend)as numeric)/ nullif(SUM(spend),0)*100 as "ROMI"
from facebook_ads_basic_daily 
where clicks > 0
group by campaign_id ,spend 
order by spend desc 
fetch first 1 row with ties 

