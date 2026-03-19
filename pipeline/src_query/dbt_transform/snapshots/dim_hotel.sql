{% snapshot dim_hotel %}

{{
    config(
      target_database='pactravel-dwh',
      target_schema='final',
      unique_key='hotel_sk',

      strategy='check',
      check_cols=[
			'hotel_sk',
			'hotel_nk',
			'hotel_name',
			'hotel_address',
			'city',
			'hotel_score',
			'start_date',
			'end_date'
		]
    )
}}

select
	{{ dbt_utils.generate_surrogate_key( ["hotel_id"] ) }} as hotel_sk, 
	hotel_id as hotel_nk,
	hotel_name,
	hotel_address,
	city,
	hotel_score,
	{{ dbt.current_timestamp() }} as start_date,
	null as end_date 
from {{ ref("stg_dwh__hotel") }}

{% endsnapshot %}