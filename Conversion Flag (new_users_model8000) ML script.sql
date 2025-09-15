CREATE OR REPLACE MODEL `ethnofusionai.ethnofusion_dataset.new_users_model8000`
OPTIONS (
  model_type = 'BOOSTED_TREE_CLASSIFIER',
  input_label_cols = ['conversion_flag'],
  max_iterations = 50,
  data_split_method = 'AUTO_SPLIT',
  enable_global_explain = TRUE
) AS
SELECT
  -- Target
  conversion_flag,

  -- Structured features
  age,
  gender,
  ethnicity,
  socioeconomic_status,
  insurance_type,
  risk_score,
  event_type,
  referral_outcome,
  device_type,
  response_latency,
  engagement_score,
  referral_source,
  referral_stage,
  drop_reason,

-- Array counts from JSON strings
ARRAY_LENGTH(REGEXP_EXTRACT_ALL(TO_JSON_STRING(SAFE.PARSE_JSON(chronic_conditions)), r'"([^"]+)"')) AS chronic_condition_count,
ARRAY_LENGTH(REGEXP_EXTRACT_ALL(TO_JSON_STRING(SAFE.PARSE_JSON(diagnosis_codes)), r'"([^"]+)"')) AS diagnosis_code_count,
ARRAY_LENGTH(REGEXP_EXTRACT_ALL(TO_JSON_STRING(SAFE.PARSE_JSON(billing_codes)), r'"([^"]+)"')) AS billing_code_count,


-- Lab result parsing from JSON object
SAFE_CAST(JSON_VALUE(lab_results, '$.WBC') AS FLOAT64) AS wbc_value,
SAFE_CAST(JSON_VALUE(lab_results, '$.HbA1c') AS FLOAT64) AS hba1c_value,
ARRAY_LENGTH(REGEXP_EXTRACT_ALL(TO_JSON_STRING(lab_results), r'"([^"]+)":')) AS lab_result_count,

  -- Embeddings
  embedding_media,
  
FROM `ethnofusionai.ethnofusion_dataset.medical_ethnography`
WHERE time_to_discharge IS NOT NULL
LIMIT 8000;
