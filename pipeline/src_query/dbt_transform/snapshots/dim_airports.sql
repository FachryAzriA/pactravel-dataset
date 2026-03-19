{% snapshot dim_airports %}

{{
    config(
      target_database='pactravel-dwh',
      target_schema='final',
      unique_key='airport_sk',

      strategy='check',
      check_cols=[
			'airport_sk',
			'airport_nk',
			'airport_name',
			'latitude',
			'longitude',
			'start_date',
			'end_date'
		]
    )
}}

select
	{{ dbt_utils.generate_surrogate_key( ["airport_id"] ) }} as airport_sk, 
	airport_id as airport_nk,
	airport_name,
    city,
	latitude,
	longitude,
	{{ dbt.current_timestamp() }} as start_date,
	null as end_date 
from {{ ref("stg_dwh__airports") }}

{% endsnapshot %}