SELECT  platform,
  COUNT(*) AS row_count
FROM `marketing_analytics_assignment.ads_unified`
GROUP BY platform
ORDER BY row_count DESC;
