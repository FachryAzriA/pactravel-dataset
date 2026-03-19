{% snapshot fct_hotel_booking_record_eachday %}

{{
    config(
      target_database='pactravel-dwh',
      target_schema='final',
      unique_key='fct_hotel_booking_record_eachday_id',

      strategy='check',
      check_cols=[
			'fct_hotel_booking_record_eachday_id',
      'booked_date',
      'number_of_booking'
		]
    )
}}

-- {{ dbt_utils.generate_surrogate_key( ["hb.trip_id"] ) }} as fct_hotel_booking_record_eachday_id, 
	       
  select {{ dbt_utils.generate_surrogate_key( ["count(hb.trip_id)"])  }} as fct_hotel_booking_record_eachday_id, 
         hb.check_in_date booked_date,
	       count(hb.trip_id)  number_of_booking
    from {{ ref("stg_dwh__hotel_bookings") }} hb
group by hb.check_in_date

{% endsnapshot %}