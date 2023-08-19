/* Script for Assignment 7 Experimets Questions - Fall 2022

Team 18
Aditi Soni
Aqsa Bhimdiwala
Kiran Gurunath Naik
Sravya Arutla */

create DATABASE dirkassignment7;

-- Connecting to database 
\c dirkassignment7

/* Common Functions used through 1-7 Problems */

--The function queryPlan returns the query plan for the given sqlStatement
create or replace function queryPlan (sqlStatement text) 
returns table (queryPlanRow text) as
$$
begin
 return  query execute 'explain analyze' || sqlStatement;
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

-- The 'experiment' function creates m relation S, with |S| = 10^k for k
-- in [k_1,k_2] and runs the (scan) query `SELECT x FROM S' n times.
-- Then the function returns the average execution times of these n
-- runs.

create or replace function experiment(m int, k_1 int, k_2 int, n int, sqlstatement text)
returns table(s int, e numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, executionTime  float);   
   
   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeS(floor(power(10,k))::int);
      insert into executionTimeTable values(floor(power(10,k))::int, (select runexperiment(n,sqlstatement)));
    end loop;
   end loop;
   return query select size::int, round(avg(executiontime)::numeric,3)
                from   executionTimeTable 
                group by(size) order by 1;
end;
$$ language plpgsql;


-- Sorting
-- The function queryPlan returns the query plan for the given sqlStatement                                                                  

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

\qecho 'Problem 1'

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

\qecho 'Problem 2'

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



/*Functions related to 3-7*/

-- Function to generate Relation: P(a int) and Q(b int) -- Similar to person Relation 
create or replace function SetOfIntegers(n int, l int, u int)
returns table (x int) as
$$
select floor(random() * (u-l+1) + l)::int as x
from generate_series(1,n)
group by (x) order by 1;
$$ language sql;


-- Function to generate Relation: R(a int, b int) -- Similar to Knows relation
create or replace function BinaryRelationOverIntegers(n int, l_1 int, u_1 int, l_2 int, u_2 int)
returns table (a int, b int) as
$$
select distinct
floor(random() * (u_1-l_1+1) + l_1)::int as a,
floor(random() * (u_2-l_2+1) + l_2)::int as b
from generate_series(1,n);
$$ language sql;

-- From Prof function file to create tables for P Relation
create or replace function makeP(n integer)
returns void as
$$
begin
drop table if exists P;
create table P (a int);
insert into P select * from SetOfIntegers(n,1,n);
end;
$$ language plpgsql;

-- From Prof function file to create tables for Q Relation
create or replace function makeQ(n integer)
returns void as
$$
begin
drop table if exists Q;
create table Q (b int);
insert into Q select * from SetOfIntegers(n,1,n);
end;
$$ language plpgsql;

-- From Prof function file to create tables for R Relation
create or replace function makeR(n int)
returns void as
$$
begin
drop table if exists R;
create table R (a int, b int);
insert into R (select * from BinaryRelationOverIntegers(n,1000,1000000000,1000,1000000000));
end;
$$ language plpgsql;

-- Function where P(nP = 100) and Q(nQ = 100). 
-- Here P and Q are in same range.
-- Varying only R values to get the excution time.
create or replace function Case1(p int, q int, r int, n int, sqlstatement1 text, sqlstatement2 text)
returns table(nP int, nQ int, nR int, e1 numeric, e2 numeric) as
$$
begin
drop table if exists executionTimeTable;
create table executionTimeTable(
    psize int,
    qsize int,
    rsize int,
    executionTime1 float,
    executionTime2 float
    );   
perform makeP(floor(power(10,p))::int);
perform makeQ(floor(power(10,q))::int);
for i in 1..r loop perform makeP(floor(power(10,i))::int);
 insert into executionTimeTable values( 
        floor(power(10,p))::int,
        floor(power(10,q))::int,
        floor(power(10,i))::int,
      (select runexperiment(n,sqlstatement1)),
      (select runexperiment(n,sqlstatement2)));
end loop;
return query select 
psize::int, 
qsize::int,
rsize::int,
round(avg(executiontime1)::numeric,3),
round(avg(executiontime2)::numeric,3)
                from executionTimeTable 
                group by(rsize, psize, qsize) order by rsize;
end;
$$ language plpgsql;

-- Function where R(nR = 10000) and Q(nQ = 100). 
-- Here P and Q are in same range.
-- Varying only P values to get the excution time.
create or replace function Case2(p int, q int, r int, n int, sqlstatement1 text, sqlstatement2 text)
returns table(nP int, nQ int, nR int, e1 numeric, e2 numeric) as
$$
begin
drop table if exists executionTimeTable;
create table executionTimeTable(
    psize int,
    qsize int,
    rsize int,
    executionTime1 float,
    executionTime2 float
    );   
perform makeQ(floor(power(10,q))::int);
perform makeR(floor(power(10,r))::int);
for i in 1..p loop perform makeP(floor(power(10,i))::int);
 insert into executionTimeTable values(floor(power(10,i))::int, 
        floor(power(10,q))::int,
        floor(power(10,r))::int,
      (select runexperiment(n,sqlstatement1)),
      (select runexperiment(n,sqlstatement2)));
end loop;
return query select 
psize::int, 
qsize::int,
rsize::int,
round(avg(executiontime1)::numeric,3),
round(avg(executiontime2)::numeric,3)
                from executionTimeTable 
                group by(psize, qsize, rsize) order by 1;
end;
$$ language plpgsql;

-- Function where R(nR = 100) 
-- Varying only P and Q values to get the excution time.
create or replace function Case3(p int, q int, r int, n int, sqlstatement1 text, sqlstatement2 text)
returns table(nP int, nQ int, nR int, e1 numeric, e2 numeric) as
$$
begin
drop table if exists executionTimeTable;
create table executionTimeTable(
    psize int,
    qsize int,
    rsize int,
    executionTime1 float,
    executionTime2 float
    );   

perform makeR(floor(power(10,r))::int);
for i in 1..p loop perform makeP(floor(power(10,i))::int);
for i in 1..q loop perform makeQ(floor(power(10,i))::int);
 insert into executionTimeTable values(floor(power(10,i))::int, 
        floor(power(10,i))::int,
        floor(power(10,r))::int,
      (select runexperiment(n,sqlstatement1)),
      (select runexperiment(n,sqlstatement2)));
end loop;
end loop;
return query select 
psize::int, 
qsize::int,
rsize::int,
round(avg(executiontime1)::numeric,3),
round(avg(executiontime2)::numeric,3)
                from executionTimeTable 
                group by(psize, qsize, rsize) order by 1;
end;
$$ language plpgsql;



\qecho 'Problem 3'
-- Case 1:
select * from Case1(2,2,6,3,'select distinct r1.a
from R r1, R r2, R r3, R r4
where r1.b = r2.a and r2.b = r3.a and r3.b = r4.a;

',
'select distinct r1.a
from R r1 natural join (select r2.a as b from R r2  natural join (select r3.a as b from R r3 natural join 
                                 (select r4.a as b from R r4 ) r4 ) r3 ) r2
');

dROP table P;
drop table Q;
drop table r;

set enable_hashjoin = on;
set enable_mergejoin = off;

-- Query Plan For SQL Statement 1

select * from queryPlan('select distinct r1.a
from R r1, R r2, R r3, R r4
where r1.b = r2.a and r2.b = r3.a and r3.b = r4.a;');

-- Query Plan For SQL Statement 2
select * from queryPlan('with temp1 as (select k1.* from P k1),
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


\qecho 'Problem 4'
-- Case 1:
select * from Case1(2,2,5,3,'select p.a
from P p
where p.a not in (select r.a
from R r
where r.b not in (select q.b
from Q q));',
'with temp1 as (select k1.* from P k1),
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

-- Case 2:
select * from Case2(7,2,2,3,'select p.a
from P p
where p.a not in (select r.a
from R r
where r.b not in (select q.b
from Q q));',
'with temp1 as (select k1.* from P k1),
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

-- Case 3:
select * from Case3(6,6,2,3,'select p.a
from P p
where p.a not in (select r.a
from R r
where r.b not in (select q.b
from Q q));',
'with temp1 as (select k1.* from P k1),
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


-- Query Plan For SQL Statement 1

select * from queryPlan('select p.a
from P p
where p.a not in (select r.a
from R r
where r.b not in (select q.b
from Q q));');

-- Query Plan for SQL Statement 2

select * from queryPlan('with temp1 as (select k1.* from P k1),
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


\qecho 'Problem 5'
-- Experimenting with Case1
select * from Case1(2,2,5,3,'select p.a
from P p
where true = all (select p.a != r.a or true = some (select r.b = q.b
from Q q)
from R r)
order by 1;',
'select w.a
from (
select p.a
from P p
except
(select r.a
from R r natural join P p
intersect 
(select x.a from (
    select r.a from R r
except
select q.b from Q q
) x)
)) w;');


select * from Case2(5,2,2,3,'select p.a
from P p
where true = all (select p.a != r.a or true = some (select r.b = q.b
from Q q)
from R r)
order by 1;',
    'select w.a
from (
select p.a
from P p
except
(select r.a
from R r natural join P p
intersect 
(
select x.a from (
select r.a from R r
except
select q.b from Q q
) x)
)) w;');

select * from Case3(5,5,2,3,'select p.a
from P p
where true = all (select p.a != r.a or true = some (select r.b = q.b
from Q q)
from R r)
order by 1;',
    'select w.a
from (
select p.a
from P p
except
(select r.a
from R r natural join P p
intersect 
(
select x.a from (
select r.a from R r
except
select q.b from Q q
) x)
)) w;');

-- Query Plan for SQL Statement 1
select * from queryPlan('select p.a
from P p
where true = all (select p.a != r.a or true = some (select r.b = q.b
from Q q)
from R r)
order by 1;');

-- Query Plan for SQL Statement 2
select * from queryPlan('select w.a
from (
select p.a
from P p
except
(select r.a
from R r natural join P p
intersect 
(select x.a from (
select r.a from R r
except
select q.b from Q q
) x)
)) w;')

-- Query Optimization 
-- Step 1: Eliminating True = all Condition.
select w.a
from (
        select p.a
        from P p
        except
        select p.a
        from R r,
            P p
        where p.a = r.a
            and not true = some (
                select r.b = q.b
                from Q q
            )
    ) w;

-- Step 2: Eliminating not true = some
select w.a
from (
        select p.a
        from P p
        except (
                select r.a
                from R r
                    natural join P p
                intersect
                (
                    select x.a
                    from (
                            select r.a
                            from R r
                            except
                            select q.b
                            from Q q
                        ) x
                )
            )
    ) w;


\qecho 'Problem 6'
-- Experimenting with Case1
select * from Case1(2,2,5,3,'select p.a
from P p
where not exists (select 1
from Q q
where (p.a, q.b) not in (select r.a, r.b
from R r));',
'select p.a
from P p
EXCEPT
select w.a from 
(select p.a,q.b from P p NATURAL JOIN Q q
except
select p.a, q.b from P p NATURAL JOIN R r JOIN Q q ON (p.a = r.a and q.b = r.b))w
ORDER BY 1;');

-- Experimenting with Case2
select * from Case2(4,2,2,3,'select p.a
from P p
where not exists (select 1
from Q q
where (p.a, q.b) not in (select r.a, r.b
from R r));',
'select p.a
from P p
EXCEPT
select w.a from 
(select p.a,q.b from P p NATURAL JOIN Q q
except
select p.a, q.b from P p NATURAL JOIN R r JOIN Q q ON (p.a = r.a and q.b = r.b))w
ORDER BY 1;');

-- Experimenting with Case3
select * from Case3(4,4,2,3,'select p.a
from P p
where not exists (select 1
from Q q
where (p.a, q.b) not in (select r.a, r.b
from R r));',
'select p.a
from P p
EXCEPT
select w.a from 
(select p.a,q.b from P p NATURAL JOIN Q q
except
select p.a, q.b from P p NATURAL JOIN R r JOIN Q q ON (p.a = r.a and q.b = r.b))w
ORDER BY 1;');


-- Query Plan For SQL Statement 1
select * from queryPlan('select p.a
from P p
where not exists (select 1
from Q q
where (p.a, q.b) not in (select r.a, r.b
from R r));');

-- Query Plan for SQL Statement 2
select * from queryPlan('select p.a
from P p
EXCEPT
select w.a from 
(select p.a,q.b from P p NATURAL JOIN Q q
except
select p.a, q.b from P p NATURAL JOIN R r JOIN Q q ON (p.a = r.a and q.b = r.b))w
ORDER BY 1;');


-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE dirkassignment7;