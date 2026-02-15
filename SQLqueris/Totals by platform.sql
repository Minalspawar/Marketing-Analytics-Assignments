SELECT
  platform,
  SUM(spend) AS total_spend,
  SUM(impressions) AS total_impressions,
  SUM(clicks) AS total_clicks,
  SUM(conversions) AS total_conversions
FROM `marketing_analytics_assignment.ads_unified`
GROUP BY platform;
