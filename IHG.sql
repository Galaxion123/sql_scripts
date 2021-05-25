select room_class as "Room Class", sum(adults + children) as "Total Adults and Children", count(distinct room) as "Total Rooms", round(count(distinct room)/578 * 100, 2) as "Percentage"
from reservation_daily_elements
where room_class in ('STD') 
and resv_status = 'CHECKED IN'
and resv_daily_el_seq in (select rden.resv_daily_el_seq from reservation_daily_element_name rden where rden.resv_name_id in (select rn.resv_name_id from reservation_name rn where resv_status = 'CHECKED IN'))
and reservation_date = pms_p.business_date
group by room_class
UNION
select room_class as "Room Class", sum(adults + children) as "Total Adults and Children",  count(distinct room) as "Total Rooms", round(count(distinct room)/148 * 100, 2) as "Percentage"
from reservation_daily_elements
where room_class in ('CLB') 
and resv_status = 'CHECKED IN'
and resv_daily_el_seq in (select rden.resv_daily_el_seq from reservation_daily_element_name rden where rden.resv_name_id in (select rn.resv_name_id from reservation_name rn where resv_status = 'CHECKED IN'))
and reservation_date = pms_p.business_date
group by room_class
