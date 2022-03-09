{{
    config(
        materialized='incremental'
    )
}}

select
    EMAIL
from PUBLIC.EMP_BASIC

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where START_DATE > (select max(MAX_DATE_FETCHED) from PUBLIC.EMP_RUN_AUDIT)

{% endif %}