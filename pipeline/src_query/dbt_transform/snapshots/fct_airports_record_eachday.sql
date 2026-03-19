{% snapshot fct_airports_record_eachday %}

{{
    config(
      target_database='pactravel-dwh',
      target_schema='final',
      unique_key='fct_airports_record_eachday_id',

      strategy='check',
      check_cols=[
			'fct_airports_record_eachday_id',
      'airport_sk',
      'booked_date',
      'number_of_booking'
		]
    )
}}

  select {{ dbt_utils.generate_surrogate_key( ["airport_sk"] ) }} as fct_airports_record_eachday_id, 
 	       a.airport_sk,
         fb.departure_date as booked_date,
	       count(fb.trip_id) number_of_booking
    from {{ ref("dim_airports") }} a,
	     {{ ref("stg_dwh__flight_bookings") }} fb
   where a.airport_nk = fb.airport_src
group by a.airport_sk,
         fb.departure_date

{% endsnapshot %}