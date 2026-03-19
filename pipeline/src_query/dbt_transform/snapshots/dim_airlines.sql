{% snapshot dim_airlines %}

{{
    config(
      target_database='pactravel-dwh',
      target_schema='final',
      unique_key='airline_sk',

      strategy='check',
      check_cols=[
			'airline_sk',
			'airline_nk',
			'airline_name',
			'country',
			'airline_iata',
			'airline_icao',
			'alias',
			'start_date',
			'end_date'
		]
    )
}}

select
	{{ dbt_utils.generate_surrogate_key( ["airline_id"] ) }} as airline_sk, 
	airline_id as airline_nk,
    airline_name,
	country,
	airline_iata,
	airline_icao,
	alias,
	{{ dbt.current_timestamp() }} as start_date,
	null as end_date 
from {{ ref("stg_dwh__airlines") }}

{% endsnapshot %}