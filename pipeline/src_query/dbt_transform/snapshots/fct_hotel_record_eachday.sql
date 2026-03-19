{% snapshot fct_hotel_record_eachday %}

{{
    config(
      target_database='pactravel-dwh',
      target_schema='final',
      unique_key='fct_hotel_record_eachday_id',

      strategy='check',
      check_cols=[
			'fct_hotel_record_eachday_id',
      'hotel_sk',
      'booked_date',
      'number_of_booking'
		]
    )
}}

  select {{ dbt_utils.generate_surrogate_key( ["h.hotel_sk"] ) }} as fct_hotel_record_eachday_id, 
 	       h.hotel_sk,
         hb.check_in_date as booked_date,
	       count(h.hotel_sk) as number_of_booking
    from {{ ref("dim_hotel") }} h,
	       {{ ref("stg_dwh__hotel_bookings") }} hb
   where h.hotel_nk = hb.hotel_id
group by h.hotel_sk,
         hb.check_in_date	 

{% endsnapshot %}