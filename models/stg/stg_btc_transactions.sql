{{config(materialized = 'ephemeral')}}

select 
* 
from {{ref("stg_btc_outputs")}}
WHERE is_coinbase = false