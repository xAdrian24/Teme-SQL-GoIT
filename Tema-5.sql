with gfa as (
	select
		fabd.ad_date,
		fabd.url_parameters,
		fc.campaign_name,
		fa.adset_name,
		fabd.spend,
		fabd.impressions,
		fabd.reach,
		fabd.clicks,
		fabd.leads,
		fabd.value
	from
		public.facebook_ads_basic_daily fabd
	left join
		public.facebook_campaign fc on fabd.campaign_id = fc.campaign_id
	left join
		public.facebook_adset fa on fabd.adset_id = fa.adset_id
	union all
	select
		ad_date,
		url_parameters,
		campaign_name,
		adset_name,
		spend,
		impressions,
		reach,
		clicks,
		leads,
		value
	from
		public.google_ads_basic_daily gabd
			order by
		ad_date
)
select	
		ad_date,
		campaign_name,
		sum(spend) as total_cost,
		sum(impressions) as nr_de_impresii,
		sum(clicks) as nr_de_clickuri,
		sum(leads) as val_totala_conversie,
	CASE
		WHEN LOWER(url_parameters) like '%nan%' THEN NULL
		ELSE LOWER(SUBSTRING(url_parameters, POSITION('utm_campaign=' IN url_parameters) + 13))
	END AS utm_campaign,
	CASE
		WHEN sum(impressions) > 0 then (sum(clicks)::numeric /sum(impressions))*100
		ELSE NULL
	END AS ctr,
	CASE
		WHEN SUM(clicks) > 0 THEN SUM(spend) / SUM(clicks)
		ELSE NULL
	END AS cpc,
	CASE
		WHEN SUM(impressions) > 0 THEN SUM(spend) / SUM(impressions) * 1000
		ELSE NULL
	END AS cpm,
	CASE
		WHEN SUM(spend) > 0 THEN (SUM(value) - SUM(spend)) / SUM(spend) * 100
		ELSE NULL
	END AS romi	
from gfa
	group by ad_date,campaign_name,url_parameters;
	
