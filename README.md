# Marketing-Analytics-Assignments

# Cross-Channel Marketing Analytics Dashboard (Facebook + Google + TikTok)

This project unifies advertising performance data from **Facebook Ads**, **Google Ads**, and **TikTok Ads** into a single analytics model in **BigQuery**, then visualizes the integrated dataset in a **one-page Looker Studio dashboard** for cross-channel performance analysis.

## Live Dashboard
- Looker Studio: https://lookerstudio.google.com/reporting/341564c1-87b8-4181-b2ab-f11942e4f856

## Data Source 
CSV files provided by the assignment:
- `01_facebook_ads.csv`
- `02_google_ads.csv`
- `03_tiktok_ads.csv`

Source repo:
https://github.com/ej29-r3d/Marketing-Analytics-Assignments/tree/main/marketing-analyst-assignment

---

## What this repo contains

### 1) SQL (BigQuery)
Located in `/sql`:
- `02_unified_model_views.sql`  
  Creates the unified views:
  - `facebook_ads_clean`
  - `google_ads_clean`
  - `tiktok_ads_clean`
  - `ads_unified`
  - `ads_unified_metrics` (dashboard-ready KPIs)

- `03_validation_checks.sql`  
  Validation queries:
  - row counts by platform  
  - totals by platform  
  - min/max date checks  
  - (optional) null checks

### 2) Report
Located in `/report`:
- `report.md` (step-by-step approach + explanation + screenshot references)

---

## BigQuery Data Model Overview

### Raw tables (loaded from CSVs)
- `marketing_analytics_assignment.facebook_ads_raw`
- `marketing_analytics_assignment.google_ads_raw`
- `marketing_analytics_assignment.tiktok_ads_raw`

### Clean views (standardized schema + types)
- `marketing_analytics_assignment.facebook_ads_clean`
- `marketing_analytics_assignment.google_ads_clean`
- `marketing_analytics_assignment.tiktok_ads_clean`

Standardizations include:
- consistent identifiers: `campaign_id`, `campaign_name`, `adgroup_id`, `adgroup_name`
- consistent types using `SAFE_CAST`
- `platform` field added for channel filtering
- platform-specific fields set to `NULL` when not available

### Unified view (cross-channel fact table)
- `marketing_analytics_assignment.ads_unified`  
Created using `UNION ALL` across clean views.

### Metrics view (dashboard-ready KPIs)
- `marketing_analytics_assignment.ads_unified_metrics`  
Adds calculated metrics such as CTR, CPC, CPA, CVR, and ROAS (where available).

---

## KPI Definitions (Dashboard)
These KPIs are computed as **ratio-of-totals** to remain accurate under filtering.

- **CTR** = `SUM(clicks) / SUM(impressions)`
- **CPC** = `SUM(spend) / SUM(clicks)`
- **CPA** = `SUM(spend) / SUM(conversions)`
- **CVR** = `SUM(conversions) / SUM(clicks)`
- **ROAS** = `SUM(conversion_value) / SUM(spend)` *(where conversion_value exists; primarily Google Ads)*

---

## How to Reproduce

### Step 1 — BigQuery dataset
Create dataset:
- `marketing_analytics_assignment`

### Step 2 — Load raw CSV tables
Create tables:
- `facebook_ads_raw`
- `google_ads_raw`
- `tiktok_ads_raw`

### Step 3 — Build unified model
Run:
- `/sql/02_unified_model_views.sql`

### Step 4 — Validate
Run:
- `/sql/03_validation_checks.sql`

### Step 5 — Dashboard
Connect Looker Studio to:
- `marketing_analytics_assignment.ads_unified_metrics`

---

## Dashboard Components
- Filters: Date range, Platform, Campaign
- KPI scorecards: Spend, Impressions, Clicks, Conversions, CTR, CPC, CPA, CVR
- Trend chart: Spend (bars) + Conversions (line) over time
- Platform comparison: performance and efficiency (CPA)
- Campaign table: top campaigns with KPI breakdown

---

## Key Insights
- Efficiency differs by channel (CPA varies by platform), enabling budget optimization.
- Spend and conversions show strong trend relationship over time, helping identify efficient vs inefficient periods.
- Results are concentrated in top campaigns, creating clear “scale winners / optimize long tail” actions.

---

## Author
Minal Pawar
