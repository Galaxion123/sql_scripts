SELECT
nr.confirmation_no,
nr.room,
nr.display_name,
ft.trx_code,
nvl(trn.description, tc.description) description,
decode( sign( nr.TRUNC_ARRIVAL - trunc(to_date(:CODATE,'dd/mm/rr'),'MM')), 1,  nr.TRUNC_ARRIVAL, trunc(to_date(:CODATE,'dd/mm/rr'),'MM') ) from_date,
nr.TRUNC_DEPARTURE,
sum(ft.gross_amount) net_amount
FROM
financial_transactions ft,
name_reservation nr,
FIN_TRX_TRANSLATION trn,
trx$_codes tc
WHERE
nr.resv_name_id=ft.resv_name_id and
decode(:ROOMCLASS, ' ALL', ' ALL', nr.room_class) in 
 (
       select regexp_substr(:ROOMCLASS,'[^,]+', 1, level) from dual
       connect by regexp_substr(:ROOMCLASS, '[^,]+', 1, level) is not null
) and
ft.trx_amount<>0 and
ft.trx_code=tc.trx_code and
ft.trx_code not in (7800,7801,7999) and
ft.resv_name_id is not null and
ft.trx_code=trn.trx_code(+) and
trn.language_code(+)='RU' and
--trunc(ft.business_date) >=  trunc(to_date(:CODATE,'dd/mm/rr'),'MM') and
ft.ft_subtype='C' and
nr.TRUNC_DEPARTURE = trunc(to_date(:CODATE,'dd/mm/rr')) and
--nr.ROOM_CATEGORY != -1
nr.payment_method<>'DB' 
group by nr.confirmation_no, 
nr.room, 
nr.display_name, 
ft.trx_code,
decode( sign( nr.TRUNC_ARRIVAL - trunc(to_date(:CODATE,'dd/mm/rr'),'MM')), 1,  nr.TRUNC_ARRIVAL, trunc(to_date(:CODATE,'dd/mm/rr'),'MM') ),
nr.TRUNC_DEPARTURE,
nvl(trn.description, tc.description)
order by nr.confirmation_no, ft.trx_code