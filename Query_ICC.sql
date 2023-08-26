use chiku

select * from icc_world_cup

INSERT INTO icc_world_cup values('Aus','India','Draw');

select Team_Name, count(1) As no_of_matches_played, SUM(CASE WHEN win_flag = 1 THEN 1 ELSE 0 END) AS no_of_matches_won,
       SUM(CASE WHEN win_flag = 0 THEN 1 ELSE 0 END) AS no_of_matches_lost,
       SUM(CASE WHEN win_flag = -1 THEN 1 ELSE 0 END) AS Draw
from(
select Team_1 As Team_Name, 
case 
when Team_1=Winner then 1 
when winner='DRAW' then -1 
else 0
end as win_flag
from icc_world_cup
union all 
select Team_2 As Team_Name, 
case
when Team_2=Winner then 1
when winner='DRAW' then -1
else 0
end as win_flag
from icc_world_cup) A
group by Team_Name
order by no_of_matches_won desc