SELECT
  COUNTIF(date IS NULL) AS null_dates,
  COUNTIF(platform IS NULL) AS null_platform,
  COUNTIF(impressions IS NULL) AS null_impressions,
  COUNTIF(clicks IS NULL) AS null_clicks,
  COUNTIF(spend IS NULL) AS null_spend
FROM `marketing_analytics_assignment.ads_unified_metrics`;
