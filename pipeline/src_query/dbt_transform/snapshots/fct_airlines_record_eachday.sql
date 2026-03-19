{% snapshot fct_airlines_record_eachday %}

{{
    config(
      target_database='pactravel-dwh',
      target_schema='final',
      unique_key='fct_airlines_record_eachday_id',

      strategy='check',
      check_cols=[
			'fct_airlines_record_eachday_id',
      'airline_sk',
			'booked_date',
      'number_of_booking'
		]
    )
}}

-- {{ dbt_utils.generate_surrogate_key("a.airline_sk") }}


  select gen_random_uuid() as fct_airlines_record_eachday_id, 
 	       a.airline_sk,
         fb.departure_date as booked_date,
	       count(fb.trip_id) number_of_booking
    from {{ ref("dim_airlines") }} a,
	       {{ ref("stg_dwh__flight_bookings") }} fb
   where a.airline_nk = fb.airline_id 
group by a.airline_sk,
         fb.departure_date

{% endsnapshot %}