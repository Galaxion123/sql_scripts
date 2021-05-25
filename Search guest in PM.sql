select
hp.name_id,
hp.xlast_name,
hp.xfirst_name,
hp.birth_date,
hp.DOC_SERIES,
hp.DOC_NO
from
hrs_dev.hrs_pm_name hp
where
xlast_name = ''
and
hp.XFIRST_NAME = ''
and
hp.name_id not in (select rn.name_id from reservation_name rn);