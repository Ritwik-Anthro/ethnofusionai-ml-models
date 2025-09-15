# ethnofusionai-ml-models
BigQuery ML scripts for modeling billing complexity, conversion flags, discharge time, and engagement tiers
This repository contains BigQuery ML scripts for modeling key operational and clinical metrics using structured data pipelines.

## Models

- **Billing Complexity** (`revenue_model8000.sql`)
- **Conversion Flag** (`new_users_model8000.sql`)
- **Discharge Time** (`hours_saved_model8000.sql`)
- **Engagement Tier** (`engagement_model8000.sql`)

Each script uses `CREATE OR REPLACE MODEL` with modality-specific features and prediction targets. See individual files for schema logic and training configurations.
