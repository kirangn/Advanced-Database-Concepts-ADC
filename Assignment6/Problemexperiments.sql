-- Script for Assignment 6  Fall 2022

-- Team 18
-- Aditi Soni
-- Aqsa Bhimdiwala
-- Kiran Gurunath Naik
-- Sravya Arutla

-- Creating database with full name


create or replace function SetOfIntegers(n int, l int, u int)
    returns table (x int) as
$$
    select floor(random() * (u-l+1) + l)::int from generate_series(1,n);
$$ language sql;

-- From Prof  function file
create or replace function makeS (n integer)
     returns void as
     $$
     begin
         drop table if exists S;
         create table S (x int);
         insert into S select * from SetOfIntegers(n,1,n);
     end;
     $$ language plpgsql;

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

-- The 'experiment' function creates m relation S, with |S| = 10^k for k
-- in [k_1,k_2] and runs the (scan) query `SELECT x FROM S' n times.
-- Then the function returns the average execution times of these n
-- runs.

--def work_mem =4MB

create or replace function experiment_scanning_sorting(m int, k_1 int, k_2 int, n int, sqlstatement1 text, sqlstatement2 text)
returns table(s int, t1 numeric, t2 numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, time1    float,  time2    float);

   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeS(floor(power(10,k))::int);
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


select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to sort S"
from experiment_scanning_sorting(3,1,8,3,'SELECT x FROM S', 'SELECT x FROM S ORDER BY 1');
--Problem 3

--def work_mem =4MB

\qecho 'Problem3'

-- Prof function for creating a table S
-- Referred https://www.postgresql.org/docs/current/how-parallel-query-works.html

\qecho 'Problem3-queryPlan10'
select makeS(10);
     explain analyze select x from S;
     explain analyze select x from S order by 1;

\qecho 'Problem3-queryPlan100'
select makeS(100);
     explain analyze select x from S;
     explain analyze select x from S order by 1;

\qecho 'Problem3-queryPlan1000'
select makeS(1000);
     explain analyze select x from S;
     explain analyze select x from S order by 1;

\qecho 'Problem3-queryPlan10000'
select makeS(10000);
     explain analyze select x from S;
     explain analyze select x from S order by 1;

\qecho 'Problem3-queryPlan100000'
select makeS(100000);
     explain analyze select x from S;
     explain analyze select x from S order by 1;

\qecho 'Problem3-queryPlan1000000'
select makeS(1000000);
     explain analyze select x from S;
     explain analyze select x from S order by 1;

\qecho 'Problem3-queryPlan10000000'
select makeS(10000000);
     explain analyze select x from S;
     explain analyze select x from S order by 1;

\qecho 'Problem3-queryPlan100000000'
select makeS(100000000);
     explain analyze select x from S;
     explain analyze select x from S order by 1;


--Problem 3B
\qecho  '3b with varying work_mem set'

\qecho  '3b with work_mem set to 64kb'
\qecho  '3b parallel = 0'


set work_mem = '64kB';
set max_parallel_workers = 0;

select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to sort S"
from experiment_scanning_sorting(3,1,8,3,'SELECT x FROM S', 'SELECT x FROM S ORDER BY 1');
explain analyze select x from S order by 1;

\qecho  '3b with work_mem set to 4mb'

set work_mem = '4MB';
select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to sort S"
from experiment_scanning_sorting(3,1,8,3,'SELECT x FROM S', 'SELECT x FROM S ORDER BY 1');
explain analyze select x from S order by 1;

\qecho  '3b with work_mem set to 32mb'
set work_mem = '32MB';
select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to sort S"
from experiment_scanning_sorting(3,1,8,3,'SELECT x FROM S', 'SELECT x FROM S ORDER BY 1');

explain analyze select x from S order by 1;

\qecho  '3b with work_mem set to 256mb'
set work_mem = '256MB';
select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to sort S"
from experiment_scanning_sorting(3,1,8,3,'SELECT x FROM S', 'SELECT x FROM S ORDER BY 1');

explain analyze select x from S order by 1;

-- set the work memory to default

set work_mem = '4MB'; --Default

\qecho 'problem 3 c -indexed' -- 3C problem

create or replace function experiment_scanning_indexSort(m int, k_1 int, k_2 int, n int)
returns table(s int, t1 numeric, t2 numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, time1    float,  time2    float);

   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeS(floor(power(10,k))::int);
      

      drop table if exists indexedS;

      create table indexedS(x integer);
      create index index_on_S on indexedS using btree(x);

      insert into executionTimeTable values(floor(power(10,k))::int, 
                                            (select runexperiment(n,'insert into indexedS select x from S order by 1')),
                                            (select runexperiment(n,'select x from indexedS where x between 1 and floor(power(10,'||k||'))::int')));
    end loop;
   end loop;
   return query select size::int, round(avg(time1)::numeric,3), round(avg(time2)::numeric,3) 
                from   executionTimeTable
                group by(size) order by 1;
end;
$$ language plpgsql;

--set work_mem = '4MB';

select s as "size of relation S", 
       t1 as "avg execution time to create index indexedS (in ms)",
       t2 as "avg execution time to range query (in ms)"
from experiment_scanning_indexSort(3,1,8,3);



\qecho 'query plan for above inserting'



\qecho 'query plan for indexeds inserting for 10 values of S'

 select makes(10);
 drop table if exists indexeds;
 create table indexedS (x integer);
 create index on indexedS using btree (x);
 insert into indexedS select x from S order by 1;
select queryPlan from queryPlan('insert into indexedS select x from S order by 1');

\qecho 'query plan for indexeds sorting  for 10 values of S'

select queryPlan from queryPlan('select x from indexedS where x between 1 and 10');


\qecho 'query plan for indexeds inserting for 10^5 values of S'

 select makes(100000);
 drop table if exists indexeds;
 create table indexedS (x integer);
 create index on indexedS using btree (x);
 insert into indexedS select x from S order by 1;
select queryPlan from queryPlan('insert into indexedS select x from S order by 1');

\qecho 'query plan for indexeds sorting  for 100000 values of S'
select queryPlan from queryPlan('select x from indexedS where x between 1 and 100000');



\qecho 'query plan for indexeds inserting for 10^8 values of S'
 select makes(10000000);
 drop table if exists indexeds;
 create table indexedS (x integer);
 create index on indexedS using btree (x);
 insert into indexedS select x from S order by 1;
select queryPlan from queryPlan('insert into indexedS select x from S order by 1');

\qecho 'query plan for indexeds sorting  for 100000000 values of S'

select queryPlan from queryPlan('select x from indexedS where x between 1 and 100000');







--4a Problem starts

\qecho 'Problem 4a -distinct' --17 mins to execute

select s as "size of relation S", 
       t1 as "avg execution distinct  (in ms)",
       t2 as "avg execution time to sort S after adding distinct (in ms)"
from experiment_scanning_sorting(3,1,8,3,'SELECT  distinct x FROM S', 'SELECT distinct x FROM S ORDER BY 1');


\qecho 'query plan for distinct'

select queryPlan from queryPlan('SELECT distinct x FROM S ORDER BY 1');

\qecho 'query plan for group by without sorting'
select queryPlan from queryPlan('SELECT  distinct x FROM S');



\qecho 'Problem 4b -groupby '

select s as "size of relation S", 
       t1 as "avg execution group by (in ms)",
       t2 as "avg execution time to group by sort S (in ms)"
from experiment_scanning_sorting(3,1,8,3,'SELECT x FROM S group by x', 'SELECT x FROM S group by x ORDER BY 1');

\qecho 'query plan for group by'

select queryPlan from queryPlan('SELECT x FROM S group by x'); 

\qecho 'query plan for group by without sorting'
select queryPlan from queryPlan('SELECT x FROM S group by x ORDER BY 1');









                     


