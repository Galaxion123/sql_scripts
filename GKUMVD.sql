select distinct
pspt.XLAST_NAME,
pspt.XFIRST_NAME,
rde.room,
pspt.nationality,
pspt.birth_date,
nr.arrival,
nr.DEPARTURE,
pspt.DOC_SERIES,
pspt.DOC_NO,
pspt.DOC_ISSUE_DATE
from name_reservation nr, 
      hrs_dev.hrs_pm_name pspt,
      reservation_daily_elements rde
where nr.name_id=pspt.name_id
and rde.RESV_DAILY_EL_SEQ in (select resv_daily_el_seq from RESERVATION_DAILY_ELEMENT_NAME where resv_name_id = nr.resv_name_id)
and nr.resv_name_id in (select resv_name_id from RESERVATION_DAILY_ELEMENT_NAME where resv_daily_el_seq in (select resv_daily_el_seq from 
RESERVATION_DAILY_ELEMENTS where room in (select room from room where suite_type not in ('PSUEDO'))))
and nr.TRUNC_ARRIVAL=to_date(:ARRDATE,'dd/mm/rr')
and nr.RESV_STATUS in ('CHECKED IN','CHECKED OUT')
and decode(:NATIO,' ALL',' ALL', pspt.nationality) in
(
        select regexp_substr(:NATIO,'[^,]+', 1, level) from dual
        connect by regexp_substr(:NATIO, '[^,]+', 1, level) is not null
)
order by pspt.XLAST_NAME;