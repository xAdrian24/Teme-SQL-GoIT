with prev_tema as (with gfa as (
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
		gabd.ad_date,
		gabd.url_parameters,
		gabd.campaign_name,
		gabd.adset_name,
		gabd.spend,
		gabd.impressions,
		gabd.reach,
		gabd.clicks,
		gabd.leads,
		gabd.value
	from
		public.google_ads_basic_daily gabd		
)
    SELECT
        DATE_TRUNC('month', ad_date) AS ad_month,
        campaign_name,
        SUM(spend) AS total_cost,
        SUM(impressions) AS nr_de_impresii,
        SUM(clicks) AS nr_de_clickuri,
        SUM(leads) AS val_totala_conversie,
        CASE
            WHEN LOWER(url_parameters) LIKE '%nan%' THEN null
            else (LOWER(substring(decode_url_part (url_parameters), '.+utm_campaign=(.*)$')))
            --ELSE LOWER(SUBSTRING(url_parameters, POSITION('utm_campaign=' IN url_parameters) +13))
        END AS utm_campaign,
        CASE
            WHEN SUM(clicks) > 0 THEN SUM(leads) / SUM(clicks)
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
    FROM gfa
    GROUP BY ad_date, campaign_name, url_parameters),
lagged_data AS (
    SELECT
        ad_month,
        utm_campaign,
        avg(ctr) as avg_ctr,
        avg(cpm) as avg_cpm,
        avg(romi) as avg_romi,
        LAG(avg(cpm), 1) OVER (PARTITION BY utm_campaign ORDER BY ad_month) AS cpm_prev_month,
  		LAG(avg(ctr), 1) OVER (PARTITION BY utm_campaign ORDER BY ad_month) AS ctr_prev_month,
  		LAG(avg(romi), 1) OVER (PARTITION BY utm_campaign ORDER BY ad_month) AS romi_prev_month 
    FROM prev_tema
    group by
    ad_month,
    utm_campaign
)
SELECT
    ad_month,
    utm_campaign,
case 
  when cpm_prev_month > 0 then ROUND((avg_cpm - cpm_prev_month ) / cpm_prev_month * 100, 2) 
  else null
  end as cpm_diff_pct,
  case 
  	when  ctr_prev_month > 0 then ROUND((avg_ctr - ctr_prev_month) / ctr_prev_month * 100, 2) 
  	else null
  end as ctr_diff_pct,
  case
  	when  romi_prev_month > 0 then ROUND((avg_romi - romi_prev_month) / romi_prev_month * 100, 2)
  end as romi_diff_pct
FROM lagged_data;
