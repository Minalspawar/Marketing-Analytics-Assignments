-- =========================================
-- Unified Ads Model (exact columns from your CSVs)
-- Dataset: marketing_analytics_assignment
-- =========================================

-- 1) Clean + standardize each platform to a common schema
CREATE OR REPLACE VIEW `marketing_analytics_assignment.facebook_ads_clean` AS
SELECT
  SAFE_CAST(date AS DATE) AS date,
  'facebook' AS platform,
  campaign_id,
  campaign_name,
  ad_set_id AS adgroup_id,
  ad_set_name AS adgroup_name,

  SAFE_CAST(impressions AS INT64) AS impressions,
  SAFE_CAST(clicks AS INT64) AS clicks,
  SAFE_CAST(spend AS NUMERIC) AS spend,
  SAFE_CAST(conversions AS INT64) AS conversions,

  SAFE_CAST(NULL AS NUMERIC) AS conversion_value,
  SAFE_CAST(video_views AS INT64) AS video_views,

  SAFE_CAST(engagement_rate AS NUMERIC) AS engagement_rate,
  SAFE_CAST(reach AS INT64) AS reach,
  SAFE_CAST(frequency AS NUMERIC) AS frequency,

  -- tiktok-specific fields set to NULL here
  CAST(NULL AS INT64) AS video_watch_25,
  CAST(NULL AS INT64) AS video_watch_50,
  CAST(NULL AS INT64) AS video_watch_75,
  CAST(NULL AS INT64) AS video_watch_100,
  CAST(NULL AS INT64) AS likes,
  CAST(NULL AS INT64) AS shares,
  CAST(NULL AS INT64) AS comments,

  -- google-specific fields set to NULL
  CAST(NULL AS NUMERIC) AS ctr,
  CAST(NULL AS NUMERIC) AS avg_cpc,
  CAST(NULL AS INT64) AS quality_score,
  CAST(NULL AS NUMERIC) AS search_impression_share
FROM `marketing_analytics_assignment.facebook_ads_raw`;


CREATE OR REPLACE VIEW `marketing_analytics_assignment.google_ads_clean` AS
SELECT
  SAFE_CAST(date AS DATE) AS date,
  'google' AS platform,
  campaign_id,
  campaign_name,
  ad_group_id AS adgroup_id,
  ad_group_name AS adgroup_name,

  SAFE_CAST(impressions AS INT64) AS impressions,
  SAFE_CAST(clicks AS INT64) AS clicks,
  SAFE_CAST(cost AS NUMERIC) AS spend,
  SAFE_CAST(conversions AS INT64) AS conversions,

  SAFE_CAST(conversion_value AS NUMERIC) AS conversion_value,
  CAST(NULL AS INT64) AS video_views,

  CAST(NULL AS NUMERIC) AS engagement_rate,
  CAST(NULL AS INT64) AS reach,
  CAST(NULL AS NUMERIC) AS frequency,

  -- tiktok-specific fields set to NULL
  CAST(NULL AS INT64) AS video_watch_25,
  CAST(NULL AS INT64) AS video_watch_50,
  CAST(NULL AS INT64) AS video_watch_75,
  CAST(NULL AS INT64) AS video_watch_100,
  CAST(NULL AS INT64) AS likes,
  CAST(NULL AS INT64) AS shares,
  CAST(NULL AS INT64) AS comments,

  SAFE_CAST(ctr AS NUMERIC) AS ctr,
  SAFE_CAST(avg_cpc AS NUMERIC) AS avg_cpc,
  SAFE_CAST(quality_score AS INT64) AS quality_score,
  SAFE_CAST(search_impression_share AS NUMERIC) AS search_impression_share
FROM `marketing_analytics_assignment.google_ads_raw`;


CREATE OR REPLACE VIEW `marketing_analytics_assignment.tiktok_ads_clean` AS
SELECT
  SAFE_CAST(date AS DATE) AS date,
  'tiktok' AS platform,
  campaign_id,
  campaign_name,
  adgroup_id AS adgroup_id,
  adgroup_name AS adgroup_name,

  SAFE_CAST(impressions AS INT64) AS impressions,
  SAFE_CAST(clicks AS INT64) AS clicks,
  SAFE_CAST(cost AS NUMERIC) AS spend,
  SAFE_CAST(conversions AS INT64) AS conversions,

  SAFE_CAST(NULL AS NUMERIC) AS conversion_value,
  SAFE_CAST(video_views AS INT64) AS video_views,

  CAST(NULL AS NUMERIC) AS engagement_rate,
  CAST(NULL AS INT64) AS reach,
  CAST(NULL AS NUMERIC) AS frequency,

  SAFE_CAST(video_watch_25 AS INT64) AS video_watch_25,
  SAFE_CAST(video_watch_50 AS INT64) AS video_watch_50,
  SAFE_CAST(video_watch_75 AS INT64) AS video_watch_75,
  SAFE_CAST(video_watch_100 AS INT64) AS video_watch_100,
  SAFE_CAST(likes AS INT64) AS likes,
  SAFE_CAST(shares AS INT64) AS shares,
  SAFE_CAST(comments AS INT64) AS comments,

  -- google-specific fields set to NULL
  CAST(NULL AS NUMERIC) AS ctr,
  CAST(NULL AS NUMERIC) AS avg_cpc,
  CAST(NULL AS INT64) AS quality_score,
  CAST(NULL AS NUMERIC) AS search_impression_share
FROM `marketing_analytics_assignment.tiktok_ads_raw`;


-- 2) Unified view (one table across all platforms)
CREATE OR REPLACE VIEW `marketing_analytics_assignment.ads_unified` AS
SELECT * FROM `marketing_analytics_assignment.facebook_ads_clean`
UNION ALL
SELECT * FROM `marketing_analytics_assignment.google_ads_clean`
UNION ALL
SELECT * FROM `marketing_analytics_assignment.tiktok_ads_clean`;


-- 3) Dashboard metrics view (common KPIs)
CREATE OR REPLACE VIEW `marketing_analytics_assignment.ads_unified_metrics` AS
SELECT
  date,
  platform,
  campaign_id,
  campaign_name,
  adgroup_id,
  adgroup_name,

  impressions,
  clicks,
  spend,
  conversions,
  conversion_value,
  video_views,

  -- Calculated KPIs (platform-neutral)
  SAFE_DIVIDE(clicks, impressions) AS calc_ctr,
  SAFE_DIVIDE(spend, clicks) AS calc_cpc,
  SAFE_DIVIDE(spend, conversions) AS calc_cpa,
  SAFE_DIVIDE(conversions, clicks) AS calc_cvr,
  SAFE_DIVIDE(conversion_value, spend) AS calc_roas,

  -- Keep native platform fields (when available)
  engagement_rate,
  reach,
  frequency,
  ctr AS google_ctr,
  avg_cpc AS google_avg_cpc,
  quality_score,
  search_impression_share,

  -- TikTok fields
  video_watch_25,
  video_watch_50,
  video_watch_75,
  video_watch_100,
  likes,
  shares,
  comments
FROM `marketing_analytics_assignment.ads_unified`;
