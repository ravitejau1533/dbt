{{
    config(
        materialized='incremental'
    )
}}

select
    *

from PUBLIC.EMP_BASIC

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where START_DATE > (select max(MAX_DATE_FETCHED) from PUBLIC.EMP_RUN_AUDIT)

{% endif %};

INSERT INTO PUBLIC.EMP_RUN_AUDIT
SELECT CURRENT_TIMESTAMP,
MAX(START_DATE)
FROM PUBLIC.EMP_BASIC;