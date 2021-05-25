select
'Total Cleaned Rooms' as "Description",
count(distinct room) as "Totals"
from
hk_action
where
action_desc like '%Dirty->Clean%'
union
select
'STD Cleaned Rooms',
count(distinct room)
from
hk_action
where
action_desc like '%Dirty->Clean%'
and
room in (select room from room where room_class in ('STD'))
union
select
'CLB Cleaned Rooms',
count(distinct room)
from
hk_action
where
action_desc like '%Dirty->Clean%'
and
room in (select room from room where room_class in ('CLB'))