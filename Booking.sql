select
SUBSTR(gt.trace_text,25) as "Booking Confirmation",
nr.confirmation_no as "Opera Confirmation",
concat(CONCAT(nr.guest_name, ', '), nr.guest_first_name) as "Last name, First name",
nr.arrival as "Arrival date",
nr.departure as "Departure date",
nr.insert_date as "Reservation date",
nr.resv_status as "Status",
nr.adults as "N of adults",
to_date(nr.departure) - to_date(nr.arrival) as "Nights",
CASE
    WHEN nr.total_revenue * 1.2 = 0
    THEN (nr.effective_rate_amount * (to_date(nr.departure) - to_date(nr.arrival)) * 1.2)
    ELSE (nr.total_revenue * 1.2)
END as "Price rate amount"
from
name_reservation nr,
guest_rsv_traces grt,
guest_traces gt
where
nr.resv_name_id = grt.resv_name_id
and
grt.trace_id = gt.trace_id
and
gt.trace_text like 'GDS RECORD LOCATOR -BK%'
and
nr.trunc_arrival=to_date(:ARRDATE,'dd/mm/rr')
and
nr.travel_agent_name='Booking.Com'
and
nr.adults not in 0
order by nr.guest_name