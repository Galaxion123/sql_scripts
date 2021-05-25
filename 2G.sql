select distinct
nr.arrival,
pspt.XLAST_NAME,
pspt.XFIRST_NAME,
pspt.birth_date,
pspt.nationality,
pspt.DOC_NO,
rde.room,
pmrn.visa_expiry_date,
nr.DEPARTURE
from name_reservation nr, 
      hrs_dev.hrs_pm_name pspt,
      reservation_daily_elements rde,
      HRS_DEV.HRS_PM_RNAME pmrn
where nr.name_id=pspt.name_id
and rde.RESV_DAILY_EL_SEQ in (select resv_daily_el_seq from RESERVATION_DAILY_ELEMENT_NAME where resv_name_id = nr.resv_name_id)
and nr.resv_name_id in (select resv_name_id from RESERVATION_DAILY_ELEMENT_NAME where resv_daily_el_seq in (select resv_daily_el_seq from 
RESERVATION_DAILY_ELEMENTS where room in (select room from room where suite_type not in ('PSUEDO'))))
and nr.TRUNC_ARRIVAL=to_date(:ARRDATE,'dd/mm/rr')
and nr.RESV_STATUS in ('CHECKED IN','CHECKED OUT')
and pspt.NATIONALITY not in ('RU')
and pspt.NAME_ID = pmrn.NAME_ID
order by pspt.XLAST_NAME;