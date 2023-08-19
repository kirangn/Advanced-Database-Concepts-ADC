
-- Script for Assignment 6  Fall 2022

-- Team 18
-- Aditi Soni
-- Aqsa Bhimdiwala
-- Kiran Gurunath Naik
-- Sravya Arutla

-- Creating database with full name

CREATE DATABASE dvgfall2022assignment6;


-- Connecting to database 
\c dvgfall2022assignment6

\qecho 'Problem 1'

CREATE TABLE P(outcome integer,
                probability float);

insert into P values --uniform values
(1,0.125),
(1,0.125),
(1,0.125),
(1,0.125),
(1,0.125),
(1,0.125),
(1,0.125),
(1,0.125);

create or replace function getUniformOutcome()
returns table (c_prob float) as
$$
with UC (outcome, c_prob) as
(select outcome, sum(probability) over (order by outcome) as Total from P)
select c_prob from UC where c_prob > random() limit (1)
$$ language sql;

create or replace function RelationOverUniformProbabilityFunction(n int ,l1 int ,u1 int ,l2 int,u2 int)
returns table (X int, Y int ) as
$$
select floor(random() * (u1-l1+1) + l1)::int as x, floor(getUniformOutcome() * (u2-l2+1) + l2)::int as  y from generate_series(1,n);
$$ language sql;

\qecho 'Running the question uniform values'
\qecho 'Test case 1'

select x,y from RelationOverUniformProbabilityFunction(100,1,150,1,8);
\qecho 'Test case 2'
select x,y from RelationOverUniformProbabilityFunction(100,1,150,1,8);
\qecho 'Test case 3'
select x,y from RelationOverUniformProbabilityFunction(100,1,150,1,8);

-- function non uniform 

create or replace function getNonUniformOutcome()
returns table (c_prob float) as
$$
with UC (outcome, c_prob) as
(select outcome, sum(probability) over (order by outcome) as Total from P)
select c_prob from UC where c_prob > random() limit (1)
$$ language sql;

create or replace function RelationOverNonUniformProbabilityFunction(n int ,l1 int ,u1 int ,l2 int,u2 int)
returns table (X int, Y int ) as
$$
select floor(random() * (u1-l1+1) + l1)::int as x, floor(getNonUniformOutcome() * (u2-l2+1) + l2)::int as  y from generate_series(1,n);
$$ language sql;

delete from P;

-- insert non-uniform P

insert into P values
(1,0.25),
(2,0.05),
(3,0.10),
(4,0.10),
(5,0.15),
(6,0.05),
(7,0.10),
(8,0.20);

\qecho 'Running the question 1 for non-uniform values '
\qecho 'Test case 1'

select x,y from RelationOverNonUniformProbabilityFunction(100,1,150,1,8);
\qecho 'Test case 2'

select x,y from RelationOverNonUniformProbabilityFunction(100,1,150,1,8);
\qecho 'Test case 3'
select x,y from RelationOverNonUniformProbabilityFunction(100,1,150,1,8);
delete from P;

------- complete problem 1

\qecho 'Problem 2'
Create table skill (skill text);

Insert into skill values
('AI'),
('Databases'),
('Networks'),
('Programming'),
('Operating Systems');


insert into P values
(1,0.25),
(2,0.05),
(3,0.10),
(4,0.10),
(5,0.15),
(6,0.05),
(7,0.10),
(8,0.20);

create or replace function RelationOverNonUniformProbabilityFunction_Problem2(n int ,l1 int ,u1 int ,skillrangestart int,skillrangeend int)
returns table (pid int, skill text ) as
$$
    with relation(x,y) as (select x,y from RelationOverNonUniformProbabilityFunction(n,l1,u1,skillrangestart,skillrangeend)),
        pid_index(skill,index) as (select skill, row_number() over (order by skill) as index from Skill)
    select x as pid, skill from relation join pid_index on pid_index.index = relation.y;
$$ language sql;

\qecho 'Test case 1'

select pid,skill from RelationOverNonUniformProbabilityFunction_Problem2(100,1,150,1,5);
\qecho 'Test case 2'

select pid,skill from RelationOverNonUniformProbabilityFunction_Problem2(100,1,150,1,5);
\qecho 'Test case 3'

select pid,skill from RelationOverNonUniformProbabilityFunction_Problem2(100,1,150,1,5);

\qecho 'Problem 5'


-- Creating the required tables

-- Student with sid as primary key.
create table Student(sid text,
                     sname text,
                     major text,
                     byear int,
                     primary key(sid));

-- Enroll without any constriants.
create table Enroll (sid text,
                     cno text,
                     grade text);

-- Inserting data into Student table
insert into Student values 
 ('s100','Eric','CS',1988),
 ('s101','Nick','Math',1991),
 ('s102','Chris','Biology',1977),
 ('s103','Dinska','CS',1978),
 ('s104','Zanna','Math',2001),
 ('s105','Vince','CS',2001);

 -- Inserting data into Enroll table
 insert into Enroll values 
 ('s100','c200','A'),
 ('s100','c201','B'),
 ('s100','c202','A'),
 ('s101','c200','B'),
 ('s101','c201','A'),
 ('s101','c202','A'),
 ('s101','c301','C'),
 ('s101','c302','A'),
 ('s102','c200','B'),
 ('s102','c202','A'),
 ('s102','c301','B'),
 ('s102','c302','A'),
 ('s103','c201','A'),
 ('s104','c201','D');

 -- Creating new table with tids as well from Enroll table
select row_number() over (order by (sid ,cno , grade)) as tid, sid, cno, grade
into UpdatedEnroll
from enroll;

-- Creating indexOnGrade table
create table indexOnGrade(
  grade text,
  gradeBucket int[],
  primary key (grade)
);

-- inserting values into indexOnGrade table
insert into indexOnGrade
select grade,
    array_agg(tid) as gradeBucket
from UpdatedEnroll
group by(grade);

select * from indexOnGrade;

-- Creating indexOnCno table
create table indexOnCno (
    cno text,
    cnoBucket int[],
    primary key(cno)
);

-- inserting values into indexOnGrade table
insert into indexOnCno
select cno,
    array_agg(tid) as cnoBucket
from UpdatedEnroll
group by(cno);

select * from indexOnCno;

-- Function to Find the intersect, union and, and not for the grades and cnos
create or replace function TidsOverlapped(booleanOperation text, c text, g text) 
returns table (tid int) as
$$
with FinalTids AS (select case 
             when booleanOperation = 'and' then  
             (
               Select ARRAY(
                select unnest(cnoBucket) from indexOnCno where cno = c
                intersect
                select unnest(gradeBucket) from indexOnGrade where grade = g )
             )
             when booleanOperation = 'or' then  
             (
               Select ARRAY(
                select unnest(cnoBucket) from indexOnCno where cno = c
                UNION
                select unnest(gradeBucket) from indexOnGrade where grade = g )

             ) 
            when booleanOperation = 'and not' then  
            (
               select ARRAY(
               select unnest(cnoBucket) from indexOnCno where cno = c
               except
               select unnest(gradeBucket) from indexOnGrade where grade = g )

               ) end as overlappedtids)
select unnest(overlappedtids) from FinalTids;
$$ language sql;


create or replace function FindStudents(booleanOperation text, c text, g text) 
returns table(sid text, sname text, major text, byear int) as
$$
select *
from   student s
where  true = some (select s.sid = sid
               from UpdatedEnroll natural join TidsOverlapped(booleanOperation, c, g));
$$ language sql;

-- Test cases to check the above functions
\qecho 'Problem 5.a'
select * from FindStudents('and', 'c202', 'A');

select * from TidsOverlapped('and', 'c202', 'A');

\qecho 'Problem 5.b'
select * from FindStudents('or', 'c202', 'A');

\qecho 'Problem 5.c'
select * from FindStudents('and not', 'c202', 'A');


\qecho 'Problem 6'

-- Creating the required tables
create table bitmapIndexOnCno(
    cno text,
    cnoBitmap text,
    primary key(cno)
);

-- Function that maps the course from the table bitmapIndexOnCno
create or replace function Bit_vectorCno(c text) 
returns text as
$$
With E AS
(select tid, case 
                   when cno = c then '1'
                   when cno <> c then '0'
                 end as values
 from updatedenroll
 ORDER BY 1)
select (array_to_string(array(select values from E),'')) from E
group by ()
$$ language sql;

-- Inserting the values into the bitmapindexes on Cnos
insert into bitmapIndexOnCno   

              select cno, Bit_vectorCno(cno)
              from   UpdatedEnroll e
              group by(cno)
              order by 1;

select * from bitmapIndexOnCno;

-- Table to store the indexes of grades in updated Enroll table
create table bitmapIndexOnGrade(
    grade text,
    gradeBitmap text,
    primary key(grade)
);


-- Function that maps the grades from the table bitmapIndexOnCno
create or replace function Bit_vectorGrade(c text) 
returns text as
$$
With F AS
(select tid, case 
                   when grade = c then '1'
                   when grade <> c then '0'
                 end as values
 from updatedenroll
 ORDER BY 1)
select (array_to_string(array(select values from F),'')) from F
group by ()
$$ language sql;

-- Inserting the values into the bitmapindexes on grades
insert into bitmapIndexOnGrade   

              select grade, Bit_vectorGrade(grade)
              from   UpdatedEnroll e
              group by(grade)
              order by 1;

select * from bitmapIndexOnGrade;



-- Functions to perform the bitwise AND/OR/AN NOT for grades and cnos.

-- Bitwise AND

create or replace function BitwiseAnd(A text, B text) 
returns table(tid int) as
$$

select tid from (
select ordinality as tid, digit
from  unnest((select regexp_split_to_array(A,''))) with ordinality as digit where digit = '1'
intersect
select ordinality as tid, digit 
from  unnest((select regexp_split_to_array(B,''))) with ordinality as digit where digit = '1') q 

$$ language sql;


-- Bitwise OR
create or replace function BitwiseOR(A text, B text) 
returns table(tid int) as
$$
select tid from (
select ordinality as tid, digit 
from  unnest((select regexp_split_to_array(A,''))) with ordinality as digit where digit = '1'
union 
select ordinality as tid, digit 
from  unnest((select regexp_split_to_array(B,''))) with ordinality as digit where digit = '1') q
$$ language sql;


-- Bitwise ANDNOT
create or replace function BitwiseANDNOT(A text, B text) 
returns table(tid int) as
$$
select tid from (
select ordinality as tid, digit
from  unnest((select regexp_split_to_array(A,''))) with ordinality as digit where digit = '1'
intersect
select ordinality as tid, digit
from  unnest((select regexp_split_to_array(B,''))) with ordinality as digit where digit = '0' ) q 
$$ language sql;


-- Function to Find the intersect, union and, and not for the grades and cnos
-- These functions inturn calls the BitwiseAND, BitwiseOR, BitwiseANDNOT
create or replace function TidsOverlappedIndex(booleanOperation text, c text, g text) 
returns table(tid int) as
$$
with FinalTids as
(   select case

    when booleanOperation = 'and' then
    (
     select ARRAY(select BitwiseAnd((select cnoBitmap from bitmapIndexOnCno where cno = c),
     (select gradeBitmap from bitmapIndexOnGrade where grade = g)))
    ) 

    when booleanOperation = 'or' then
    (select ARRAY(select BitwiseOR((select cnoBitmap from bitmapIndexOnCno where cno = c),
     (select gradeBitmap from bitmapIndexOnGrade where grade = g)))
    )

    when booleanOperation = 'and not' then
    (select ARRAY(select BitwiseANDNOT((select cnoBitmap from bitmapIndexOnCno where cno = c),
     (select gradeBitmap from bitmapIndexOnGrade where grade = g)))
     
    )
    end as Tids    
     ) 

select unnest(Tids) from FinalTids
$$ language sql;


create or replace function NewFindStudents(booleanOperation text, c text, g text) 
returns table(sid text, sname text, major text, byear int) as
$$
select *
from   student s
where  true = some (select s.sid = sid
               from UpdatedEnroll natural join TidsOverlappedIndex(booleanOperation, c, g));
$$ language sql;


-- Testcases to test the above written function for the 
\qecho 'Problem 6.a'
select * from NewFindStudents('and', 'c202', 'A');

\qecho 'Problem 6.b'
select * from NewFindStudents('or', 'c202', 'A');

\qecho 'Problem 6.c'
select * from NewFindStudents('and not', 'c202', 'A');


-- Connect to default database
\c postgres

-- Drop database created for this assignment

DROP DATABASE dvgfall2022assignment6;

