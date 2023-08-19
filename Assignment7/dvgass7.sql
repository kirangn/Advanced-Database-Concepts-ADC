-- Script for Assignment 7  Fall 2022

-- Team 18
-- Aditi Soni
-- Aqsa Bhimdiwala
-- Kiran Gurunath Naik
-- Sravya Arutla

-- Experiments 


create or replace function queryPlan (sqlStatement text) 
returns table (queryPlanRow text) as
$$
begin
 return  query execute 'explain analyze ' || sqlStatement;
end;
$$ language plpgsql;

-- The function extractExecutionTime extracts the execution time of
-- the query plan for the given sqlStatement

create or replace function extractExecutionTime(sqlStatement text)
returns       float as
$$
   select substring(q.queryPlan,'([0-9.]+)')::float
   from   (select queryPlan from queryPlan(sqlStatement)) q
   where  q.queryPlan like '%Exec%';
$$ language sql;

-- The function runExperiment runs 'n' experiment for the
-- given queryStatement and returns their average execution time

create or replace function runExperiment(n int, queryStatement text) 
returns float as
$$
    select avg((select * from extractExecutionTime(queryStatement)))
    from   generate_series(1,n);
$$ language sql;

CREATE OR REPLACE FUNCTION makePerson (n integer) RETURNS VOID AS $$
begin
drop table if exists P;
create table P (a int);
insert into P select * from SetOfIntegers(n,1,n);
end;
$$ LANGUAGE plpgsql;

select makePerson(100)
select makedatabaseSkill(100)
select Knows(100)

CREATE OR REPLACE FUNCTION makedatabaseSkill (n integer) RETURNS VOID AS $$
begin
drop table if exists Q;
create table Q (b int);
insert into Q select * from SetOfIntegers(n,1,n);
end;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION Knows (n integer) RETURNS VOID AS $$
begin
drop table if exists R;
create table R (a int, b int);
insert into R select * from BinaryRelationOverIntegers(n,1,n,1,n);
end;
$$ LANGUAGE plpgsql;


-- Poblem1

set enable_mergejoin =on ;
set enable_hashjoin = on;

with rY as (select r1.a, array_agg(r2.b) as y from R r1 natural join R r2 group by(r1.a)),
     sZ as (select r3.a, array_agg(r4.b) as y from R r3 natural join R r4 group by(r3.a))
select z1.* from (
select rY.a, sZ.a from rY natural join sZ 
except 
select rY.a, sZ.a from rY join sZ on (rY.y &&  sZ.y)
)z1

select knows(100);

select queryPlan from queryPlan('with rY as (select r1.a, array_agg(r2.b) as y from R r1 natural join R r2 group by(r1.a)),
     sZ as (select r3.a, array_agg(r4.b) as y from R r3 natural join R r4 group by(r3.a))
select z1.* from (
select rY.a, sZ.a from rY natural join sZ 
except 
select rY.a, sZ.a from rY join sZ on (rY.y &&  sZ.y)
)z1');

select s as "size of relation S", 
       t1 as "avg execution time for RA SQL query",
       t2 as "random projection query"
from RAExperiment(3,4,5,3,'with rY as (select r1.a, array_agg(r2.b) as y from R r1 natural join R r2 group by(r1.a)),
     sZ as (select r3.a, array_agg(r4.b) as y from R r3 natural join R r4 group by(r3.a))
select z1.* from (
select rY.a, sZ.a from rY natural join sZ 
except 
select rY.a, sZ.a from rY join sZ on (rY.y &&  sZ.y)
)z1','Select * from R');

-- Problem 2 query
set enable_mergejoin =off ;
set enable_hashjoin = off;

with R3 as (select r1.a, array_agg(r2.b) as bs from R r1 natural join R r2 group by (r1.a)),
     R4 as (select r1.a, array_agg(r2.b) as bs from R r1 natural join R r2 group by (r1.a))

select r5.a , r6.a
from R3 r5, R4 r6
where not (r5.bs <@ (select bs from R4 where a = r5.a) );

select queryPlan from queryPlan('with R3 as (select r1.a, array_agg(r2.b) as bs from R r1 natural join R r2 group by (r1.a)),
     R4 as (select r1.a, array_agg(r2.b) as bs from R r1 natural join R r2 group by (r1.a))

select r5.a , r6.a
from R3 r5, R4 r6
where not (r5.bs <@ (select bs from R4 where a = r5.a) );');

select s as "size of relation S", 
       t1 as "avg execution time for Pure SQL query",
       t2 as "avg execution time optimized RA query"
from RAExperiment(3,4,6,3,'with R3 as (select r1.a, array_agg(r2.b) as bs from R r1 natural join R r2 group by (r1.a)),
     R4 as (select r1.a, array_agg(r2.b) as bs from R r1 natural join R r2 group by (r1.a))

select r5.a , r6.a
from R3 r5, R4 r6
where not (r5.bs <@ (select bs from R4 where a = r5.a) );');

-- RA experiment table

create or replace function RAExperiment(m int, k_1 int, k_2 int, n int, sqlstatement1 text, sqlstatement2 text)
returns table(s int, t1 numeric, t2 numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, time1    float,  time2    float);

   for i in 1..m loop
     for k in k_1..k_2 loop
      perform Knows(floor(power(10,k))::int);
      insert into executionTimeTable values(floor(power(10,k))::int, 
                                            (select runexperiment(n,sqlstatement1)),
                                            (select runexperiment(n,sqlstatement2)));
    end loop;
   end loop;
   return query select size::int, round(avg(time1)::numeric,3), round(avg(time2)::numeric,3) 
                from   executionTimeTable
                group by(size) order by 1;
end;
$$ language plpgsql;

--query1 could not be optimized much

select s as "size of relation S", 
       t1 as "avg execution time for Pure SQL query",
       t2 as "avg execution time optimized RA query"
from RAExperiment(3,4,6,3,'select distinct r1.a
from R r1, R r2, R r3, R r4
where r1.b = r2.a and r2.b = r3.a and r3.b = r4.a', 'select distinct r1.a
from R r1 natural join (select r2.a as b from R r2  natural join (select r3.a as b from R r3 natural join 
								 (select r4.a as b from R r4 ) r4 ) r3 ) r2');

--query 2 optimized better than the previous query
select s as "size of relation S", 
       t1 as "avg execution time for Pure SQL query",
       t2 as "avg execution time optimized RA query"
from RAExperiment(3,4,6,3,'select distinct r1.a
from R r1, R r2, R r3, R r4
where r1.b = r2.a and r2.b = r3.a and r3.b = r4.a', 'select distinct r1.a
from R r1
join R r2 on r1.b=r2.a
join R r3 on r2.b = r3.a
join R r4 on r3.b = r4.a ');
--query IN

select distinct r1.a from R r1 where r1.b in(select distinct r2.a from R r2 where r2.b
								   in (select distinct r3.a from R r3 where r3.b
								   in (select distinct r4.a from R r4 
								    ) ))

select queryPlan from queryPlan('select distinct r1.a
from R r1, R r2, R r3, R r4
where r1.b = r2.a and r2.b = r3.a and r3.b = r4.a');


select queryPlan from queryPlan( 'select distinct r1.a
from R r1 natural join (select r2.a as b from R r2  natural join (select r3.a as b from R r3 natural join 
								 (select r4.a as b from R r4 ) r4 ) r3 ) r2');


-- Problem 4
create or replace function RAExperiment_Prob2(m int, k_1 int, k_2 int, n int, sqlstatement1 text, sqlstatement2 text)
returns table(s int, t1 numeric, t2 numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, time1    float,  time2    float);

   for i in 1..m loop
     for k in k_1..k_2 loop
      perform Knows(floor(power(10,k))::int);
      perform makePerson(floor(power(10,k))::int);
      perform makedatabaseSkill(floor(power(10,k))::int);

      insert into executionTimeTable values(floor(power(10,k))::int, 
                                            (select runexperiment(n,sqlstatement1)),
                                            (select runexperiment(n,sqlstatement2)));
    end loop;
   end loop;
   return query select size::int, round(avg(time1)::numeric,3), round(avg(time2)::numeric,3) 
                from   executionTimeTable
                group by(size) order by 1;
end;
$$ language plpgsql;

select distinct p.a
from P p
where p.a not in (select r.a
from R r
where r.b  not in (select q.b
from Q q));


-- query 4
select q1.a from (
select k1.*
from P k1
except
select k1.*
from P k1,(select q3.a from (
select r.*
from R r
except 
select r.*
from R r ,Q q 
where r.b = q.b) q3) k
where k.a =k1.a )q1

-- query 4 optimized version

select q1.a from (
select k1.*
from P k1
except
select k1.*
from P k1 NATURAL join (select q3.a from (
select r.*
from R r
except 
select r.*
from R r NATURAL join Q q ) q3) k)q1 ;

-- temp view created

with temp1 as (select k1.* from P k1),
     temp2 as (select q3.a from (
                        select r.*
                        from R r
                        except 
                        select r.*
                        from R r NATURAL join Q q ) q3)
select q1.a from (
select * from temp1
except
select * from 
temp1 NATURAL join (select * from temp2 ) k ) q1

10000	3.935	8.386
100000	18.819	38.409
1000000	2326.063	458.754

-- Running this query as in whole took  more than hour. so i went manually to get the details

select s as "size of relation S", 
       t1 as "avg execution time for Pure SQL query",
       t2 as "avg execution time optimized RA query"

from RAExperiment_Prob2(3,4,6,3,'select distinct p.a
from P p
where p.a not in (select r.a
from R r
where r.b  not in (select q.b
from Q q));', 'with temp1 as (select k1.* from P k1),
     temp2 as (select q3.a from (
                        select r.*
                        from R r
                        except 
                        select r.*
                        from R r NATURAL join Q q ) q3)
select q1.a from (
select * from temp1
except
select * from 
temp1 NATURAL join (select * from temp2 ) k ) q1');

--set different values for P and Q and R at maximum values

select makePerson(1000);
select makedatabaseSkill(100);
      

select s as "size of relation S", 
       t1 as "avg execution time for Pure SQL query",
       t2 as "avg execution time optimized RA query"
from RAExperiment(3,4,6,3,'select distinct p.a
from P p
where p.a not in (select r.a
from R r
where r.b  not in (select q.b
from Q q));', 'with temp1 as (select k1.* from P k1),
     temp2 as (select q3.a from (
                        select r.*
                        from R r
                        except 
                        select r.*
                        from R r NATURAL join Q q ) q3)
select q1.a from (
select * from temp1
except
select * from 
temp1 NATURAL join (select * from temp2 ) k ) q1');

select queryPlan from queryPlan('select distinct p.a
from P p
where p.a not in (select r.a
from R r
where r.b  not in (select q.b
from Q q));');

select queryPlan from queryPlan('with temp1 as (select k1.* from P k1),
     temp2 as (select q3.a from (
                        select r.*
                        from R r
                        except 
                        select r.*
                        from R r NATURAL join Q q ) q3)
select q1.a from (
select * from temp1
except
select * from 
temp1 NATURAL join (select * from temp2 ) k ) q1');


select makePerson(10000);
select makedatabaseSkill(1000);


select makePerson(100000);
select makedatabaseSkill(10000);

