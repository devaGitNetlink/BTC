{{ config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = 'HASH_KEY'
) }}

WITH source AS (

    SELECT *
    FROM {{ source('btc', 'BTC') }}   

),

final AS (

    SELECT
    *
    FROM source

)

SELECT * FROM final

{% if is_incremental() %}
WHERE BLOCK_TIMESTAMP >= (
  SELECT max(BLOCK_TIMESTAMP)
  FROM {{ this }}
)
{% endif %}