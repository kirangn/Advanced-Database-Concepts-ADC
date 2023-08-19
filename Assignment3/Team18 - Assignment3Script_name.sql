-- Script for Assignment 3

--Team 18
--Aqsa Bhimdiwala
--Sravya Arutla
--Kiran Gurunath Naik
--Aditi Soni

-- Creating database with full name

CREATE DATABASE team18database;

-- Connecting to database 
\c team18database

-- Relation schemas and instances for assignment 3

CREATE TABLE Person(pid integer,
                    pname text,
                    city text,
                    primary key (pid));

CREATE TABLE Company(cname text,
                     headquarter text,
                     primary key (cname));

CREATE TABLE Skill(skill text,
                   primary key (skill));


CREATE TABLE worksFor(pid integer,
                      cname text,
                      salary integer,
                      primary key (pid),
                      foreign key (pid) references Person (pid),
                      foreign key (cname) references Company(cname));


CREATE TABLE companyLocation(cname text,
                             city text,
                             primary key (cname, city),
                             foreign key (cname) references Company (cname));


CREATE TABLE personSkill(pid integer,
                         skill text,
                         primary key (pid, skill),
                         foreign key (pid) references Person (pid) on delete cascade,
                         foreign key (skill) references Skill (skill) on delete cascade);


CREATE TABLE hasManager(eid integer,
                        mid integer,
                        primary key (eid, mid),
                        foreign key (eid) references Person (pid),
                        foreign key (mid) references Person (pid));

CREATE TABLE Knows(pid1 integer,
                   pid2 integer,
                   primary key(pid1, pid2),
                   foreign key (pid1) references Person (pid),
                   foreign key (pid2) references Person (pid));



INSERT INTO Person VALUES
     (1001,'Jean','Cupertino'),
     (1002,'Vidya', 'Cupertino'),
     (1003,'Anna', 'Seattle'),
     (1004,'Qin', 'Seattle'),
     (1005,'Megan', 'MountainView'),
     (1006,'Ryan', 'Chicago'),
     (1007,'Danielle','LosGatos'),
     (1008,'Emma', 'Bloomington'),
     (1009,'Hasan', 'Bloomington'),
     (1010,'Linda', 'Chicago'),
     (1011,'Nick', 'MountainView'),
     (1012,'Eric', 'Cupertino'),
     (1013,'Lisa', 'Indianapolis'), 
     (1014,'Deepa', 'Bloomington'), 
     (1015,'Chris', 'Denver'),
     (1016,'YinYue', 'Chicago'),
     (1017,'Latha', 'LosGatos'),
     (1018,'Arif', 'Bloomington'),
     (1019,'John', 'NewYork');

INSERT INTO Company VALUES
     ('Apple', 'Cupertino'),
     ('Amazon', 'Seattle'),
     ('Google', 'MountainView'),
     ('Netflix', 'LosGatos'),
     ('Microsoft', 'Redmond'),
     ('IBM', 'NewYork'),
     ('ACM', 'NewYork'),
     ('Yahoo', 'Sunnyvale');


INSERT INTO worksFor VALUES
     (1001,'Apple', 65000),
     (1002,'Apple', 45000),
     (1003,'Amazon', 55000),
     (1004,'Amazon', 55000),
     (1005,'Google', 60000),
     (1006,'Amazon', 60000),
     (1007,'Netflix', 50000),
     (1008,'Amazon', 50000),
     (1009,'Apple',60000),
     (1010,'Amazon', 55000),
     (1011,'Google', 70000), 
     (1012,'Apple', 45000),
     (1013,'Yahoo', 55000),
     (1014,'Apple', 50000), 
     (1015,'Amazon', 60000),
     (1016,'Amazon', 55000),
     (1017,'Netflix', 60000),
     (1018,'Apple', 50000),
     (1019,'Microsoft', 50000);

INSERT INTO companyLocation VALUES
   ('Apple', 'Bloomington'),
   ('Amazon', 'Chicago'),
   ('Amazon', 'Denver'),
   ('Amazon', 'Columbus'),
   ('Google', 'NewYork'),
   ('Netflix', 'Indianapolis'),
   ('Netflix', 'Chicago'),
   ('Microsoft', 'Bloomington'),
   ('Apple', 'Cupertino'),
   ('Amazon', 'Seattle'),
   ('Google', 'MountainView'),
   ('Netflix', 'LosGatos'),
   ('Microsoft', 'Redmond'),
   ('IBM', 'NewYork'),
   ('Yahoo', 'Sunnyvale');

INSERT INTO Skill VALUES
   ('Programming'),
   ('AI'),
   ('Networks'),
   ('OperatingSystems'),
   ('Databases');

INSERT INTO personSkill VALUES
 (1001,'Programming'),
 (1001,'AI'),
 (1002,'Programming'),
 (1002,'AI'),
 (1004,'AI'),
 (1004,'Programming'),
 (1005,'AI'),
 (1005,'Programming'),
 (1005,'Networks'),
 (1006,'Programming'),
 (1006,'OperatingSystems'),
 (1007,'OperatingSystems'),
 (1007,'Programming'),
 (1009,'OperatingSystems'),
 (1009,'Networks'),
 (1010,'Networks'),
 (1011,'Networks'),
 (1011,'OperatingSystems'),
 (1011,'AI'),
 (1011,'Programming'),
 (1012,'AI'),
 (1012,'OperatingSystems'),
 (1012,'Programming'),
 (1013,'Programming'),
 (1013,'OperatingSystems'),
 (1013,'Networks'),
 (1014,'OperatingSystems'),
 (1014,'AI'),
 (1014,'Networks'),
 (1015,'Programming'),
 (1015,'AI'),
 (1016,'OperatingSystems'),
 (1016,'AI'),
 (1017,'Networks'),
 (1017,'Programming'),
 (1018,'AI'),
 (1019,'Networks');

INSERT INTO hasManager VALUES
 (1004, 1003),
 (1006, 1003),
 (1015, 1003),
 (1016, 1004),
 (1016, 1006),
 (1008, 1015),
 (1010, 1008),
 (1013, 1007),
 (1017, 1013),
 (1002, 1001),
 (1009, 1001),
 (1014, 1012),
 (1011, 1005);


INSERT INTO Knows VALUES
 (1011,1009),
 (1007,1016),
 (1011,1010),
 (1003,1004),
 (1006,1004),
 (1002,1014),
 (1009,1005),
 (1018,1009),
 (1007,1017),
 (1017,1019),
 (1019,1013),
 (1016,1015),
 (1001,1012),
 (1015,1011),
 (1019,1006),
 (1013,1002),
 (1018,1004),
 (1013,1007),
 (1014,1006),
 (1004,1014),
 (1001,1014),
 (1010,1013),
 (1010,1014),
 (1004,1019),
 (1018,1007),
 (1014,1005),
 (1015,1018),
 (1014,1017),
 (1013,1018),
 (1007,1008),
 (1005,1015),
 (1017,1014),
 (1015,1002),
 (1018,1013),
 (1018,1010),
 (1001,1008),
 (1012,1011),
 (1002,1015),
 (1007,1013),
 (1008,1007),
 (1004,1002),
 (1015,1005),
 (1009,1013),
 (1004,1012),
 (1002,1011),
 (1004,1013),
 (1008,1001),
 (1008,1019),
 (1019,1008),
 (1001,1019),
 (1019,1001),
 (1004,1003),
 (1006,1003),
 (1015,1003),
 (1016,1004),
 (1016,1006),
 (1008,1015),
 (1010,1008),
 (1017,1013),
 (1002,1001),
 (1009,1001),
 (1011,1005),
 (1014,1012);





\qecho 'Problem 1'

\qecho 'Problem 1.a'

-- Write an RA expression in standard notation that expresses this
-- if-then-else query
Drop table F;
create table E1 (x integer);
create table E2 (x integer);
create table F (c text);


insert into E1 values (1), (2);
insert into E2 values (3), (4);

select q.*
from ( select e1.* from E1 e1 
	  except 
      select e1.* from E1 e1 cross join F ) q 
union 
select e2.* 
from E2 e2 cross join F ;

\qecho 'Problem 1.b'

-- Test your solution for the following E1, E2, and F

-- Note F is the empty set
select q.*
from ( select e1.* from E1 e1 
	  except 
      select e1.* from E1 e1 cross join F ) q 
union 
select e2.* 
from E2 e2 cross join F ;


\qecho 'Problem 1.c'

-- Test you solution for the following E1, E2, and F

-- insert into F values ('a'), ('b'), ('c');

-- Note that F is not an empty set.
insert into F values ('a'), ('b'), ('c');


select q.*
from ( select e1.* from E1 e1 
	  except 
      select e1.* from E1 e1 cross join F ) q 
union 
select e2.* 
from E2 e2 cross join F ;



\qecho 'Problem 2'

-- Consider the following boolean SQL query:

drop table F;

create table F(x integer, y integer);

select true = all (select p1 = p2
                   from   F p1, F p2
                   where  p1.x = p2.x)  "isaFunction";

\qecho 'Problem 2.a'

-- Using the insights you gained from Problem 1, write an RA SQL query
-- that expresses the above boolean SQL query.
select true as isafunction
except 
select true as isafunction from F p1 join F p2 on p1.x = p2.x and p1<>p2
UNION
select false as isafunction from F p1 join F p2 on p1.x = p2.x and p1<>p2;

\qecho 'Problem 2.b'

-- Test your query for F = {}
select true as isafunction
except 
select true as isafunction from F p1 join F p2 on p1.x = p2.x and p1<>p2
UNION
select false as isafunction from F p1 join F p2 on p1.x = p2.x and p1<>p2;


\qecho 'Problem 2.c'

-- Test your query for F = {(1,10),(2,20)}

insert into F values (1,10), (2,20);
select true as isafunction
except 
select true as isafunction from F p1 join F p2 on p1.x = p2.x and p1<>p2
UNION
select false as isafunction from F p1 join F p2 on p1.x = p2.x and p1<>p2;



\qecho 'Problem 2.d'

-- Test your query for F = {(1,10),(1,20),(2,20)}

insert into F values (1,20);
select true as isafunction
except 
select true as isafunction from F p1 join F p2 on p1.x = p2.x and p1<>p2
UNION
select false as isafunction from F p1 join F p2 on p1.x = p2.x and p1<>p2;



\qecho 'Problem 6'

/*
Consider the query “Find the pid and pname of each persons who knows
no-one who works for the Apple company.” 

A possible way to write this
query in Pure SQL is
*/

select p.pid, p.pname
from   Person p
where  false = all (select exists (select 1
                                   from   worksFor w
                                   where  p1.pid = w.pid and w.cname = 'Apple') and
                           (p.pid,p1.pid) = some (select k.pid1, k.pid2
                                                  from   Knows k)                                            
                    from   Person p1);

\qecho 'Problem 6a.'

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.

-- Step 1: Translating 'false=all' using except

-- explain analyse
select q.pid, q.pname
from (select distinct p.* from person p

      EXCEPT

      select distinct p.* from person p, person p1, worksfor w
      where p1.pid = w.pid and w.cname = 'Apple' and
      (p.pid,p1.pid) = some (select k.pid1, k.pid2 from knows k)
      )q
order by 1;

-- Step 2: Translating '(p.pid, p1.pid) = some ' 

-- explain analyse
select distinct q.pid, q.pname
from (select p.* from person p

      EXCEPT
      
      select distinct p.* from person p, person p1, worksfor w, knows k
      where p1.pid = w.pid and w.cname = 'Apple' and p.pid=k.pid1 and p1.pid = k.pid2

      )q
order by 1;


-- Step 3: Translating 'and' in where clause using intersect

-- explain analyse
select distinct q.pid, q.pname
from (select p.* from person p

      EXCEPT
      
      select q1.*
      from ( select distinct p.* from person p, person p1, knows k
             where p.pid = k.pid1 and p1.pid = k.pid2

             INTERSECT
        
             select distinct p.* from person p, person p1, worksfor w, knows k
             where p1.pid = w.pid and w.cname = 'Apple' and p.pid=k.pid1 and p1.pid = k.pid2
             
             ) q1 

      )q
order by 1;

-- Step 4: Translating using cross join and joins on conditions

-- explain analyse
select distinct q.pid, q.pname
from (select p.* from person p

      EXCEPT
      
      select q1.*
      from ( select distinct p.* from person p cross join person p1 
             join knows k on (p.pid = k.pid1 and p1.pid = k.pid2)

             INTERSECT

             select distinct p.* from person p cross join person p1 
             join knows k on (p.pid = k.pid1 and p1.pid = k.pid2) join worksfor w on (p1.pid = w.pid and w.cname = 'Apple')          
             
            ) q1 

      )q
order by 1;
	

\qecho 'Problem 6b.'

-- Using Approach 2, optimize this RA SQL query and provide the optimized
-- expression in RA SQL.  Specify at least three conceptually different
-- rewrite rules that you used during the optimization.


-- Step 1 : Adding views to the RA SQL obtained in 6(a) and re-writing the same.

with E as (
    select distinct p.* from person p cross join person p1 
             join knows k on (p.pid = k.pid1 and p1.pid = k.pid2)),
     F as (
    select distinct p.* from person p cross join person p1 
             join knows k on (p.pid = k.pid1 and p1.pid = k.pid2) join worksfor w on (p1.pid = w.pid and w.cname = 'Apple')
)

select q.pid, q.pname from 
( 
select p.* from person P

EXCEPT

select q1.* from (
          select e.* from E e 
          
          INTERSECT 

          select f.* from F f
       )q1
)q
order by 1;

-- Step 2: Optimising the above RA SQL


-- The optimisation of above expression is leading to P - (E and F). Here (E and F) optimises to (P - F) when the Approach 1 is followed.
-- As the F is the subset of the E, (E and F) = F alone.
-- Hence the only view F is used further down the process.


with F as (
    select distinct p.* from person p cross join person p1 
             join knows k on (p.pid = k.pid1 and p1.pid = k.pid2) join worksfor w on (p1.pid = w.pid and w.cname = 'Apple')
)

select q.pid, q.pname from 
( 
select p.* from person P

EXCEPT

select f.* from F 
)q
order by 1;


-- Step 4: Optimising the F expression

-- In the F_opt, the projection over the join on conditions is implemented for the F alone for the Knows and worksfor relations.

-- explain analyse
with F_opt1 as (select distinct p.* from person p cross join person p1 
             join (select pid1, pid2 from knows)k on (p.pid = k.pid1 and p1.pid = k.pid2) join (select pid, cname from worksfor)w on  p1.pid = w.pid and w.cname = 'Apple')

select q.pid, q.pname from 
(
select p.* from person P

EXCEPT

select f.* from F_opt1 f 
)q
order by 1;

-- Step 5: Optimising the F expression

-- In the F_opt obtained above, cross join is removed by discrading the person p1. 

-- explain analyse
with F_opt2 as (select distinct p.* from person p join (select pid1, pid2 from knows)k on p.pid = k.pid1 join 
(select pid, cname from worksfor)w on (k.pid2=w.pid and w.cname = 'Apple'))

select q.pid, q.pname from 
(
select p.* from person P

EXCEPT

select f.* from F_opt2 f 
)q
order by 1;


-- Step 6: Optimising the F expression

-- In the F_opt obtained above, 'w.cname = 'Apple''  is brought inside the select clause and selecting only the 
-- required attribute columns.

-- explain analyse
with F_opt2 as (select distinct p.pid, p.pname from person p join (select pid1, pid2 from knows)k on p.pid = k.pid1 join 
(select pid from worksfor w where w.cname = 'Apple')w on k.pid2=w.pid )

select q.pid, q.pname from 
(
select p.pid, p.pname from person P

EXCEPT

select f.pid, f.pname from F_opt2 f 
)q
order by 1;




\qecho 'Problem 7a.'

/*
Find each pair $(c,p)$ where $c$ is the cname of a company and $p$ is
the pid of a person who works for that company and who earns strictly
more than all other persons who work for that company and who earns
more than 60000


A possible way to write this
query in Pure SQL is*/

select c.cname, p.pid
from   Company c, Person p
where  p.pid in (select w.pid
                 from   worksFor w
                 where  w.cname = c.cname and
                        true = all (select w1.salary <= 60000
                                    from   worksFor w1
                                    where  p.pid != w1.pid and 
                                           w1.cname = c.cname and
                                           w.salary <= w1.salary));

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.
										  
--Step 1 simplying where clause to convert AND to INTERSECT
select c.cname, p.pid
from   Company c, Person p
where  p.pid in (select q.pid
                from (select * from worksfor w
					  where w.cname = c.cname
					  
					  INTERSECT
					  
					  select * 
					  from worksfor w
					  where true = all (select w1.salary <= 60000
                                   from   worksFor w1
                                   where  p.pid != w1.pid and 
                                          w1.cname = c.cname and
                                          w.salary <= w1.salary)) q			
				
				);
--Step 2 Removing true=all condition by introducing EXCEPT
select c.cname, p.pid
from   Company c, Person p
where  p.pid in (select q.pid
                from (select * from worksfor w
					  where w.cname = c.cname
					  
					  INTERSECT
					  
					  select q1.*
					  from (select w.*
							from worksfor w
							EXCEPT
							select w.*
							from worksfor w, worksfor w1
							where p.pid != w1.pid and 
                                  w1.cname = c.cname and
                                  w.salary <= w1.salary AND
									w1.salary > 60000
					  
					  		)q1	
				
				)q);	
				
--Step 3 Removing IN clause
				
select c.cname, p.pid
from   Company c, Person p, worksfor w
where  w.cname = c.cname and p.pid = w.pid

INTERSECT

(select c.cname, p.pid
from   Company c, Person p, worksfor w
where p.pid = w.pid

EXCEPT

select c.cname, p.pid
from   Company c, Person p, worksfor w, worksfor w1
where p.pid = w.pid and p.pid != w1.pid and 
                                  w1.cname = c.cname and
                                  w.salary <= w1.salary AND
									w1.salary > 60000)
									order by 1;
									
--Step 4 Removing constant condition from where clause
			
select c.cname, p.pid
from   Company c, Person p, worksfor w
where  w.cname = c.cname and p.pid = w.pid

INTERSECT

(select c.cname, p.pid
from   Company c, Person p, worksfor w
where p.pid = w.pid

EXCEPT

select c.cname, p.pid
from   Company c, Person p, worksfor w, (select * from worksfor w1 where w1.salary > 60000) w1
where p.pid = w.pid and p.pid != w1.pid and 
                                  w1.cname = c.cname and
                                  w.salary <= w1.salary
									)
									order by 1,2;
									
-- Step 5 Replacing commas in the from clause by Introducing natural joins, cross joins and JOIN ON
select c.cname, p.pid
from   (Company c NATURAL JOIN worksfor w) NATURAL JOIN Person p

INTERSECT

(select c.cname, p.pid
from   Company c CROSS JOIN (Person p NATURAL JOIN worksfor w)
EXCEPT
select c.cname, p.pid
from  ( (Company c NATURAL JOIN (select * from worksfor w1 where w1.salary > 60000) w1) JOIN (Person p NATURAL JOIN worksfor w) 
ON	(p.pid != w1.pid and w.salary <= w1.salary))
 )
	order by 1,2;		


\qecho 'Problem 7b.'


-- Using Approach 2, optimize this RA SQL query and provide the optimized
-- expression in RA SQL.  Specify at least three conceptually different
-- rewrite rules that you used during the optimization.

--Step 1 - simplifying the relation removing redundant intersection from the RA SQL expression obtained above
WITH E AS
(select c.cname, p.pid
from   (Company c NATURAL JOIN worksfor w) NATURAL JOIN Person p),

F AS
(select c.cname, p.pid
from  (Company c NATURAL JOIN (select * from worksfor w1 where w1.salary > 60000) w1) JOIN (Person p NATURAL JOIN worksfor w) 
ON	(p.pid != w1.pid and w.salary <= w1.salary)
)
select w.cname, w.pid
from (select e.*
	 from E e
	 EXCEPT
	 select f.*
	 from F f) w
	 ORDER by 1,2;
	 
-- STEP 2 optimizing the view E by eliminating the Company and Person relation using foreign key constraint 
WITH E_opt AS
(select w.cname, w.pid
from   worksfor w),

F AS
(select c.cname, p.pid
from  (Company c NATURAL JOIN (select * from worksfor w1 where w1.salary > 60000) w1) JOIN (Person p NATURAL JOIN worksfor w) 
ON	(p.pid != w1.pid and w.salary <= w1.salary)
)
select w.cname, w.pid
from (select e.*
	 from E_opt e
	 EXCEPT
	 select f.*
	 from F f) w
	 ORDER by 1,2;
	 
--STEP 3 optimizing F by pushing projection over joins and removing company and Person relation
WITH E_opt AS
(select w.cname, w.pid
from   worksfor w),

F_opt AS
(select w1.cname, w.pid
from   (select * from worksfor w1 where w1.salary > 60000) w1 JOIN (select w.pid,w.salary from worksfor w) w
ON	(w.pid != w1.pid and w.salary <= w1.salary))

select w.cname, w.pid
from (select e.*
	 from E_opt e
	 EXCEPT
	 select f.*
	 from F_opt f) w
	 ORDER by 1,2;


\qecho 'Problem 8a.'

/*Find the pid of each person who has all-but-one job skill

A possible way to write this
query in Pure SQL is*/

select p.pid
from   person p
where  exists (select 1
               from   skill s
               where  not (p.pid, s.skill) in (select ps.pid, ps.skill
                                               from   personSkill ps)) and
       true = all (select s1.skill = s2.skill
                   from   skill s1, skill s2
                   where  (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                                    from   personSkill ps) and
                          (p.pid, s2.skill) not in (select ps.pid, ps.skill 
                                                    from   personSkill ps));
		    
-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.


-- true=all --> not exists 
select p.pid
from Person p
		where exists (select 1
						from skill s
						where not (p.pid, s.skill) in (select ps.pid, ps.skill
						from personSkill ps)) 
						and
			not exists (select 1 
						from skill s1, skill s2
						where (p.pid, s1.skill) not in (select ps.pid, ps.skill
						from personSkill ps)and
						(p.pid, s2.skill)  not in (select ps.pid, ps.skill
						from personSkill ps) and s1 <> s2);

-- and --> intersects

select p.pid
from Person p
		where exists (select 1
						from skill s
						where not (p.pid, s.skill) in (select ps.pid, ps.skill
						from personSkill ps)) 
					intersect

select p.pid
from Person p where 
not exists (select 1 
						from skill s1, skill s2
						where (p.pid, s1.skill) not in (select ps.pid, ps.skill
						from personSkill ps)and
						(p.pid, s2.skill)  not in (select ps.pid, ps.skill
						from personSkill ps) and s1 <> s2);

-- not exists -->except

select p.pid
from Person p
		where exists (select 1
						from skill s
						where  (p.pid, s.skill) not in (select ps.pid, ps.skill
						from personSkill ps)) 
						intersect
select q.pid
from ( select p.pid
	  from person p
	  except
	  select p.pid from person p,
	  skill s1, skill s2
						where (p.pid, s1.skill) not in (select ps.pid, ps.skill
						from personSkill ps)
						and 
						(p.pid, s2.skill)  not  in (select ps.pid, ps.skill
						from personSkill ps) 
						and s1 <> s2)q;


-- remove exists from the above intersects

select p.pid
from Person p,skill s
		where (p.pid, s.skill) not in (select ps.pid, ps.skill
						from personSkill ps)						
		intersect
select q.pid
from ( select p.pid
	  from person p
	  except
	  select p.pid from person p,skill s1, skill s2
						where (p.pid, s1.skill) not in (select ps.pid, ps.skill
						from personSkill ps)
						and 
						(p.pid, s2.skill)  not  in (select ps.pid, ps.skill
						from personSkill ps) 
						and s1 <> s2)q;



-- not-in to except 

select w.pid from 
(select y.pid
from(select  p.pid,s.skill  from Person P,skill s
		except 
		select  p.pid,s.skill from Person p, skill s ,personskill ps 
	 where ps.pid=p.pid and ps.skill=s.skill) y	
		
		intersect
		
( select p.pid
  from person p
   except
  select  z.pid from   
 (select  p.pid,s1.skill,s2.skill
 from person p,skill s1, skill s2
where s1.skill <> s2.skill
 except
 select  p.pid,s1.skill,s2.skill
 from person p,skill s1,personskill ps,skill s2
 where p.pid=ps.pid and ps.skill = s1.skill
 except
 select p.pid,s1.skill,s2.skill
 from person p,skill s2,personskill ps,skill s1
 where p.pid=ps.pid and ps.skill = s2.skill) z)) w;

-- introducing joins 

select w.pid from 
(select y.pid
from(select  p.pid,s.skill  from Person P cross join skill s
		except 
		select  p.pid,s.skill from Person p  join  personskill ps on p.pid=ps.pid join skill s on ps.skill=s.skill) y	
		
		intersect
		
( select p.pid
  from person p
   except
  select  z.pid from   
 (select  p.pid,s1.skill,s2.skill
 from person p cross join skill s1 join skill s2 on s1.skill <> s2.skill
 except
 select  p.pid,s1.skill,s2.skill
 from person p join personskill ps on ps.pid=p.pid join skill s1 on ps.skill = s1.skill cross join skill s2
 except
 select p.pid,s1.skill,s2.skill
 from person p join  personskill ps on p.pid=ps.pid join skill s2 on ps.skill = s2.skill cross join skill s1) z))w ;



\qecho 'Problem 8b.'

-- Using Approach 2, optimize this RA SQL query and provide the optimized
-- expression in RA SQL.  Specify at least three conceptually different
-- rewrite rules that you used during the optimization.

-- optimization step1: defining E and F


With E as (select y.pid
from(select  p.pid,s.skill  from Person P cross join skill s
		except 
		select  p.pid,s.skill from Person p  join  personskill ps on p.pid=ps.pid join skill s on ps.skill=s.skill) y),	

 F as ( select p.pid
  from person p
   except
  select  z.pid from   
 (select  p.pid,s1.skill,s2.skill
 from person p cross join skill s1 join skill s2 on s1.skill <> s2.skill
 except
 select  p.pid,s1.skill,s2.skill
 from person p join personskill ps on ps.pid=p.pid join skill s1 on ps.skill = s1.skill cross join skill s2
 except
 select p.pid,s1.skill,s2.skill
 from person p join  personskill ps on p.pid=ps.pid join skill s2 on ps.skill = s2.skill cross join skill s1) z)
 
  select E.pid FROM
  E e INTERSECT
  select F.pid from 
  F f ;
		
		
-- As E-F above is F as E belongs to F the above query can be written in

With FOpt as ( select p.pid
  from person p
   except
  select  z.pid from   
 (select  p.pid,s1.skill,s2.skill
 from person p cross join skill s1 join skill s2 on s1.skill <> s2.skill
 except
 select  p.pid,s1.skill,s2.skill
 from person p join personskill ps on ps.pid=p.pid join skill s1 on ps.skill = s1.skill cross join skill s2
 except
 select p.pid,s1.skill,s2.skill
 from person p join  personskill ps on p.pid=ps.pid join skill s2 on ps.skill = s2.skill cross join skill s1) z)
 

  select f.pid from 
  FOpt f ;

-- simplified the joins 

with FOpt as ( select p.pid
  from person p
   except
  select  z.pid from   
 (select  p.pid,s1.skill,s2.skill
 from person p cross join skill s1 join skill s2 on s1.skill <> s2.skill
 except
 select  p.pid,s1.skill,s2.skill
 from person p natural join personskill ps  natural join skill s1  cross join skill s2
 except
 select p.pid,s1.skill,s2.skill
 from person p natural join  personskill ps natural join skill s2  cross join skill s1) z)
 

  select f.pid from 
  FOpt f ;

-- removing constraints as personskill already has pid referencing primary key pid from person

with FOpt as ( select p.pid
  from person p
   except
  select  z.pid from   
 (select  p.pid,s1.skill,s2.skill
 from person p cross join skill s1 join skill s2 on s1.skill <> s2.skill
 except
 select  ps.pid,s1.skill,s2.skill
 from  personskill ps  natural join skill s1  cross join skill s2
 except
 select ps.pid,s1.skill,s2.skill
 from   personskill ps natural join skill s2  cross join skill s1) z)
 

  select f.pid from 
  FOpt f ;

-- further simplification on Fopt by creating the "skills"

with skills as (select ps.pid,s1.skill as skill1,s2.skill as skill2 from  personskill ps natural join skill s2  cross join skill s1),
 FOpt as ( select p.pid
  from person p
   except
  select  z.pid from   
 (select  p.pid,s1.skill,s2.skill
 from person p cross join skill s1 join skill s2 on s1.skill <> s2.skill
 except
 select  ss.pid,ss.skill2,ss.skill1
 from skills ss
 except
 select ss.pid,ss.skill1,ss.skill2
 from   skills ss) z)
 

  select f.pid from 
  FOpt f ;


\qecho 'Problem 9a.'

/*
Consider the query ``\emph{Find the cname of each company that (1) is
not located in Chicago, (2) employs at least one person and (3) whose
workers who make strictly less 60000 neither have the programming
skill nor the AI skill

A possible way to write this
query in Pure SQL is*/

select c.cname
from   company c
where  c.cname in (select w.cname
                   from   worksfor w 
                   where  not exists (select 1
                                      from   companyLocation cl 
                                      where  w.cname = cl.cname and 
                                             cl.city = 'Chicago')) and
       true = all (select p.pid not in (select ps.pid
                                         from   personSkill ps
                                         where  ps.skill = 'Programming' or
                                                ps.skill = 'AI')
                   from   Person p
                   where  p.pid in (select w.pid
                                     from   worksFor w
                                     where  w.cname = c.cname and
                                            w.salary < 60000));

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.


--Step 1: Translation of 'and' in the where clause  to - intersect in the from clause.

select q.cname
from (select c.*
	 from company c
	 where  c.cname in (select w.cname
                         from   worksfor w 
                         where  not exists (select 1
                                            from   companyLocation cl 
                                            where  w.cname = cl.cname and cl.city = 'Chicago'))
	 intersect
	 select c.*
	 from company c
	 where true = all (select p.pid not in (select ps.pid
                                             from   personSkill ps
                                             where  ps.skill = 'Programming' or ps.skill = 'AI')
                        from   Person p
                        where  p.pid in (select w.pid
                                         from   worksFor w
                                         where  w.cname = c.cname and w.salary < 60000)))q;

--Step 2: Translation of 'not exists' in the first part of the intersection statement to negation of condition - moving constant conditions.

select q.cname
from ( select c.*
	  from company c, worksfor w, companyLocation cl
	  where  c.cname = w.cname and w.cname = cl.cname and cl.city <> 'Chicago'
	 intersect
	  select c.*
	  from company c
	  where true = all (select p.pid not in (select ps.pid
                                              from   personSkill ps
                                              where  ps.skill = 'Programming' or ps.skill = 'AI')
                         from   Person p
                         where  p.pid in (select w.pid
                                          from   worksFor w
                                          where  w.cname = c.cname and w.salary < 60000)))q;

--Step 3: Translation of 'true=all' in the second part of the intersection statement to 'not exists'.

select q.cname
from ( select c.*
	  from company c, worksfor w, companyLocation cl
	  where  c.cname = w.cname and w.cname = cl.cname and cl.city <> 'Chicago'
	 intersect
	  select c.*
	  from company c
	  where not exists ( select 1 
                          from( select ps.pid
                                from   personSkill ps
                                where  ps.skill = 'Programming' or ps.skill = 'AI') z, Person p
                          where  exists (select 1
                                         from   worksFor w
                                         where  p.pid = w.pid and w.cname = c.cname and w.salary < 60000) and z.pid = p.pid ))q;

--Step 4: Translation of 'exists' in the last condition of 'not exists' - Moving constant conditions.

select q.cname
from ( select c.*
	  from company c, worksfor w, companyLocation cl
	  where  c.cname = w.cname and w.cname = cl.cname and cl.city <> 'Chicago'
	 intersect
	  select c.*
	  from company c
	  where not exists (select 1 
					from  ( select ps.pid
                                 from  personSkill ps
                                 where  ps.skill = 'Programming' or ps.skill = 'AI') z, Person p, worksFor w
                         where  p.pid = w.pid and w.cname = c.cname and w.salary < 60000 and z.pid = p.pid ))q;

--Step 5: Transaltion of 'not exists' in the second part of the intersection statement to 'except'.

select q.cname
from (select c.*
	  from company c, worksfor w, companyLocation cl
	  where  c.cname = w.cname and w.cname = cl.cname and cl.city <> 'Chicago'
	 intersect
	  select c.*
	  from company c
	  except
	  select c.*
	  from company c, (select ps.pid
                        from   personSkill ps
                        where  ps.skill = 'Programming' or ps.skill = 'AI') z, Person p, worksFor w
       where  p.pid = w.pid and w.cname = c.cname and w.salary < 60000 and z.pid = p.pid)q;

--Step 6: View created for - person skilled in either programming or AI.


create or replace view sec1 as
					     select ps.pid
                              from   personSkill ps
                              where  ps.skill = 'Programming' or ps.skill = 'AI';

select q.cname
from (select c.*
	 from company c, worksfor w, companyLocation cl
	 where  c.cname = w.cname and w.cname = cl.cname and cl.city <> 'Chicago'
	 intersect
	 select c.*
	 from company c
	 except
	 select c.*
	 from company c, (select pid
                       from   sec1)z, Person p, worksFor w
      where  p.pid = w.pid and w.cname = c.cname and w.salary < 60000 and z.pid = p.pid )q;

--Step 7: Translation by introdcuing natural joins in the FROM clause.

create or replace view sec1 as
					     select ps.pid
                              from   personSkill ps
                              where  ps.skill = 'Programming' or ps.skill = 'AI';
select q.cname
from ( select c.*
	  from company c natural join worksfor w natural join companyLocation cl
	  where  cl.city <> 'Chicago'
	  intersect
	  select c.*
	  from company c
	  except
	  select c.*
	  from company c natural join worksFor w natural join Person p natural join (select pid
                                                                                  from   sec1)z
       where  w.salary < 60000 )q;


\qecho 'Problem 9b.'
	       
-- Using Approach 2, optimize this RA SQL query and provide the optimized
-- expression in RA SQL.  Specify at least three conceptually different
-- rewrite rules that you used during the optimization.

-- Step 1 : Observing as per approach 1, query can be expressed as πc.cname(E ∩ (C − F))
--          This can be replaced as   πc.cname(E − F)

create or replace view sec1 as
					     select ps.pid
                              from   personSkill ps
                              where  ps.skill = 'Programming' or ps.skill = 'AI';

with 
E as (select c.*
	 from company c natural join worksfor w natural join companyLocation cl
	 where  cl.city <> 'Chicago'),
F as (select c.*
	 from company c natural join worksFor w natural join Person p natural join (select pid
                                                                                 from   sec1)z
      where  w.salary < 60000 )
select c.cname
from (select e.*
	 from E e
	 except
	 select f.*
	 from F f)c;

-- Step 2 : When concentrating on expression E, we push the projection over the join 
--          We finally get the simplied version as E_opt = C n σcity!= Chicago(cL).

create or replace view sec1 as
					     select ps.pid
                              from   personSkill ps
                              where  ps.skill = 'Programming' or ps.skill = 'AI';
                         
with 
E_opt as (select c.*
	     from company c natural join worksfor w natural join (select cl.cname
												   from companyLocation cl
												   where cl.city <> 'Chicago')cl),
F as (select c.*
	from company c natural join worksFor w natural join Person p natural join (select pid
                                                                                from   sec1)z
                                                                                where  w.salary < 60000)
select c.cname
from (select e.*
	 from E_opt e
	 EXCEPT
	 select f.*
	 from F f)c;

-- Step 3 : When concentrating on expression F, we push the projection over the join
--          and get the optimized expression as the one displayed in F_opt

create or replace view sec1 as
					     select ps.pid
                              from   personSkill ps
                              where  ps.skill = 'Programming' or ps.skill = 'AI';

with 
E_opt as (select c.*
	  from company c natural join worksfor w natural join (select cl.cname
												from companyLocation cl
												where cl.city <> 'Chicago')cl),
F_opt as (select c.*
	  from company c join worksFor w on (c.cname = w.cname and w.salary < 60000) natural join Person p natural join (select pid
                                                                                                                      from   sec1)z)
select c.cname
from (select e.*
	 from E_opt e
	 EXCEPT
	 select f.*
	 from F_opt f)c;
	 

\qecho 'Problem 10a'

-- Consider the following Pure SQL query.

select p.pid, exists (select 1
                      from   hasManager hm1, hasManager hm2
                      where  hm1.mid = p.pid and hm2.mid = p.pid and
                             hm1.eid <> hm2.eid)
from   Person p;

-- This query returns a pair (p,t) if p is the pid of a person who
-- manages at least two persons and returns the pair (p,f) other- wise.11

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.


-- Step 1 : Translating query using 'exixts', 'non exists' and 'union' to get distinct outputs

(select p.pid, 'true' as bool
from   Person p
where  exists (select 1
               from   hasManager hm1, hasManager hm2
               where  hm1.mid = p.pid and hm2.mid = p.pid and
                      hm1.eid <> hm2.eid)
union

select p.pid, 'false' as bool
from   Person p
where  not exists (select 1
                   from   hasManager hm1, hasManager hm2
                   where  hm1.mid = p.pid and hm2.mid = p.pid and
                          hm1.eid <> hm2.eid) )order by pid;


-- Step 2 : Translating 'exists' to constant conditions and 'not exists' to 'except' 

select p.pid,'true' as bool 
from Person p,hasManager hm1,hasManager hm2 
where hm1.mid=p.pid and hm2.mid=p.pid and hm1.eid<>hm2.eid

UNION

(select q.pid,'false' as bool 
 from (select p.pid
	   from Person p
  	   EXCEPT
  	   select p.pid 
  	   from Person p, hasManager hm1,hasManager hm2
  	   where hm1.mid=p.pid and hm2.mid=p.pid and hm1.eid<>hm2.eid)q) order by pid;

-- Step 3 - Translating second statement in 'union' clause

select p.pid,'true' as booleanvalue 
from Person p,hasManager hm1,hasManager hm2
where hm1.mid=p.pid and hm2.mid=p.pid and hm1.eid<>hm2.eid

UNION

(select q.pid,'false' as booleanvalue 
from (select p.pid
	  from Person p
      EXCEPT
      select p.pid
	  from hasManager hm1 join Person p on (hm1.mid=p.pid) join hasManager hm2 on (hm2.mid=p.pid and hm1.eid<>hm2.eid))q) order by pid;

-- Step 4 - Translating first statement in 'union' clause

select p.pid,'true' as booleanvalue 
from hasManager hm1 join Person p on (hm1.mid=p.pid) join hasManager hm2 on (hm2.mid=p.pid and hm1.eid<>hm2.eid)

UNION

(select q.pid,'false' as booleanvalue 
 from (select p.pid
	  from Person p
       EXCEPT
       select p.pid
	  from hasManager hm1 join Person p on (hm1.mid=p.pid) join hasManager hm2 on (hm2.mid=p.pid and hm1.eid<>hm2.eid))q) order by pid;


\qecho 'Problem 10b'

-- Using Approach 2, optimize this RA SQL query and provide the optimized
-- expression in RA SQL.  Specify at least three conceptually different
-- rewrite rules that you used during the optimization.

-- Step 1 : Observing as per approach 1, query can be expressed as πp.pid(F U (E − F))
--          This can be replaced as   πc.cname(E − F)

with 
E as(select p.pid
	 from Person p),
F as(select p.pid
	 from hasManager hm1 join Person p on (hm1.mid=p.pid) join hasManager hm2 on (hm2.mid=p.pid and hm1.eid<>hm2.eid))
 
select p.pid, 'true' as booleanvalue 
from (select f.*
	 from F f)p
 UNION
 (select p.pid, 'false' as booleanvalue 
from (select e.*
	  from E e
	  EXCEPT
	  select f.*
	  from F f)p) order by pid;
 

-- Step 2 : Optimizing E and F to get the fully optimized query 
--                   Here F was optimized by eliminating join with Person 

with 
E_opt as(select p.pid
	 from Person p),
F_opt as(select q.mid
	 from (select hm1.mid 
		   from hasManager hm1 join hasManager hm2 on (hm1.mid = hm2.mid and hm1.eid <> hm2.eid))q)
	

select p.mid, 'true' as booleanvalue 
from (select f.*
	 from F_opt f)p 
 UNION 
(select q.pid, 'false' as booleanvalue 
from ( select e.*
	  from E_opt e
	  EXCEPT
	  select f.*
	  from F_opt f)q) order by 1,2; 

-- Step 3 : Optimizing F further by pushing the projection inwards 

with 
E_opt as(select p.pid
	 from Person p),
F_opt as(select hm1.mid 
		 from hasManager hm1 join hasManager hm2 on (hm1.mid = hm2.mid and hm1.eid <> hm2.eid))
	

select p.mid, 'true' as booleanvalue 
from (select f.*
	 from F_opt f)p 
 UNION 
(select q.pid, 'false' as booleanvalue 
from ( select e.*
	  from E_opt e
	  EXCEPT
	  select hm1.*
	  from F_opt hm1)q) order by 1,2; 


\qecho 'Problem 11'

/*
Find each pair (c, a, l, u) where ‘c’ is the cname of a company that
pays each of its employees a salary between 50000 and 60000, ‘a′ is
the average salary of the employees who work for company ‘c’, ‘l’ is
the number of employees who earn a salary strictly below this average,
and ‘u’ is the number of employees who earn at least this average.
*/
WITH high_pay_company AS
(select wf.pid, wf.cname, wf.salary,(select AVG(salary) from worksfor 
								    	where cname=wf.cname) as avg_salary
from worksfor wf where true = all(select (salary>=50000 and salary <=60000)
								  from worksfor
								  where cname=wf.cname)
)				
select distinct hpc.cname as c, hpc.avg_salary, 
				(select COUNT(pid) from worksfor where cname=hpc.cname and salary <hpc.avg_salary) as l,
				(select COUNT(pid) from worksfor where cname=hpc.cname and salary >=hpc.avg_salary) as u
from high_pay_company hpc;

		   
		   
\qecho 'Problem 12'

/*
Find each skill that is the skill of at least 3 persons who each know
at least 2 persons who work for Apple and whose salary is at most 50000.
*/

CREATE VIEW apple_emp AS
select w.pid from worksfor w where w.cname='Apple' and w.salary <= 50000;

CREATE VIEW knows_apple AS
select k.pid1, COUNT(k.pid2) as total_pid2
from knows k
where k.pid2 IN (select ap.pid from apple_emp ap) 
GROUP BY(k.pid1);

WITH final_person AS
(select ka.pid1
from knows_apple ka
where ka.total_pid2 >=2)

select ps.skill
from (select ps.skill, COUNT(ps.pid) as p_count
		from personskill ps
		where ps.pid IN (select pid1 from final_person)
 		GROUP BY(ps.skill)) ps
where ps.p_count >= 3;



	

\qecho 'Problem 13'


/*
Find the pid and name of each person p who has at least 3 job skills
in combined set of job skills of the persons who are managed by p.
*/
WITH manager_skill AS 
(select distinct hm.mid, count(distinct ps.skill) as skill_count
from hasmanager hm, personskill ps
where hm.mid = ps.pid and 
ps.skill in (select p.skill
			from personskill p
			where p.pid in (select h.eid
						   from hasmanager h
						   where h.mid = hm.mid))
						   
						   group by (hm.mid))
select p.pid, p.pname
from person p
where p.pid in (select ms.mid
			   from manager_skill ms
			   where ms.skill_count>=3);




\qecho 'Problem 14'

/*
Find the cname of each company that employs at least 4 persons and
that pays the highest average salary among such companies.
*/
WITH wf AS
(select w.cname, count(w.pid) as p_count, avg(w.salary) as average
from worksfor w
group by(w.cname))

select wf.cname
from wf
where wf.p_count>=4 and wf.average >= ALL(select average
					from wf
					   where wf.p_count>=4);



				 


\qecho 'Problem 15'

/*
Without using subquery expressions, find each pid of a person who
knows each person who earns the highest salary at company Amazon.
*/
with max_salary_pid AS
(select wf.pid from worksfor wf where wf.cname = 'Amazon' and wf.salary = (select max(salary)
																	from worksfor
																	where cname='Amazon'))
select q.pid1
from (select k.pid1, COUNT(k.pid2) as p_count
	  from knows k,max_salary_pid msp 
	  where k.pid2 = msp.pid
	  group by(k.pid1)) q
where q.p_count = (select count(ms)
					from max_salary_pid ms) ;



\qecho 'Problem 16'

/*
Without using subquery expressions, find each pairs (p1,p2) of pids of
different persons such that if s is a job skill of p1 then s is also a
job skill of person p2.
*/
select distinct p1.pid, p2.pid
from person p1, person p2
where p1.pid != p2.pid and
(select COUNT(q)
from 
(select skill from personskill where pid=p1.pid
 INTERSECT 
 select skill from personskill where pid=p2.pid

)q )= 0;

		   

\qecho 'Problem 17'

/* Find each pairs (p1,p2) of different pids of persons p1 and p2
and such that (1) the number of skills of person s1 is strictly less
than the number of skills of person s2 and (2) such that the gap
between these numbers is the largest among all such possible gaps.
 */

CREATE VIEW personskillall AS
select p.pid, (select COUNT(ps) from personskill ps where ps.pid=p.pid) as s_count 
 from person p 
group by(p.pid);

CREATE VIEW person_skill_diff AS
select ps1.pid as pid1, ps2.pid as pid2, (ps2.s_count - ps1.s_count) as diff
from personskillall ps1, personskillall ps2
where ps1.pid != ps2.pid and ps1.s_count < ps2.s_count;

select psd.pid1, psd.pid2
from person_skill_diff psd
where psd.diff = (select MAX(ps.diff)
				 from person_skill_diff ps);


\qecho 'Problem 18'
WITH low AS
(select * from worksfor where salary<=50000),
medium as
(select * from worksfor where salary>=50001 and salary<=60000),
high as
(select * from worksfor where salary>=60001)

select co.cname, (select 'low') as type1, (select COUNT(l.pid) from low l where l.cname=co.cname) AS ctEmployees
from company co
group by co.cname

UNION

(select co.cname, (select 'medium') as type1, (select COUNT(m.pid) from medium m where m.cname=co.cname) AS ctEmployees
from company co
group by co.cname)

UNION

(select co.cname, (select 'high') as type1, (select COUNT(h.pid) from high h where h.cname=co.cname) AS ctEmployees
from company co
group by co.cname)

ORDER BY 1,2;


-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE team18database;






