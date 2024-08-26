with marketing as (
select fabd.ad_date, fc.campaign_name, fabd.spend, fabd.impressions, fabd.reach, fabd.clicks, fabd.leads, fabd.value
from facebook_ads_basic_daily fabd 
left join facebook_adset fa on fa.adset_id = fabd.adset_id
left join facebook_campaign fc on fc.campaign_id = fabd.campaign_id
union 
select ad_date, campaign_name, spend, impressions, reach, clicks, leads, value
from google_ads_basic_daily gabd
) 
select ad_date, campaign_name, 
sum (spend) as costul_total, sum(impressions) as nr_impresii, sum(clicks) as nr_clickuri,
sum(value) as valoare_totala_conversie
from marketing
where spend >0
group by ad_date, campaign_name;

-- Locker Stuio link https://lookerstudio.google.com/reporting/b2f5d8e0-b4b0-485a-8a75-a4c355d80691 
