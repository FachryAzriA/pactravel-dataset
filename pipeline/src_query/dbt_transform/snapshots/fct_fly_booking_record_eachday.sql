{% snapshot fct_fly_booking_record_eachday %}

{{
    config(
      target_database='pactravel-dwh',
      target_schema='final',
      unique_key='fct_fly_booking_record_eachday_id',

      strategy='check',
      check_cols=[
			'fct_fly_booking_record_eachday_id',
      'booked_date',
      'number_of_booking'
		]
    )
}}

-- {{ dbt_utils.generate_surrogate_key( ["fb.trip_id"] ) }} as fct_fly_booking_record_eachday_id, 

  select {{ dbt_utils.generate_surrogate_key( ["count(fb.trip_id)"] ) }} as fct_fly_booking_record_eachday_id, 
         fb.departure_date as booked_date,
	       count(fb.trip_id) number_of_booking
    from {{ ref("stg_dwh__flight_bookings") }} fb
group by fb.departure_date

{% endsnapshot %}