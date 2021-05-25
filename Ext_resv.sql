select
rnj.resv_name_id,
ra.insert_date,
ra.ACTION_TYPE,
SUBSTR(ra.ACTION_DESCRIPTION, INSTR(ra.ACTION_DESCRIPTION, 'LOSCH') , INSTR(ra.ACTION_DESCRIPTION,';', INSTR(ra.ACTION_DESCRIPTION, 'LOSCH')))
from
RESERVATION_NAME_JRNL rnj,
RESERVATION_ACTION ra
where
rnj.ACTION_INSTANCE_ID = ra.ACTION_INSTANCE_ID
and
ra.business_date = to_date(:SEARCH_DATE,'dd/mm/rr')
and
ra.action_type = 'UPDATE RESERVATION'
and
ra.ACTION_DESCRIPTION like '%LOSCH%';