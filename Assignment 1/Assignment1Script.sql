-- Creating database with full name


CREATE DATABASE dirkassignment;

-- Connecting to database 
\c dirkassignment;

-- Relation schemas and instances for assignment 1

\qecho 'Problem 1'

-- Provide 4 conceptually different examples that illustrate how the
-- presence or absence of primary and foreign keys affect insert and
-- deletes in these relations.  To solve this problem, you will need to
-- experiment with the relation schemas and instances for this
-- assignment.  For example, you should consider altering primary keys
-- and foreign key constraints and then consider various sequences of
-- insert and delete operations.  You may need to change some of the
-- relation instances to observe the desired effects.  Certain inserts
-- and deletes should succeed but other should generate error
-- conditions.  (Consider the lecture notes about keys, foreign keys,
-- and inserts and deletes as a guide to solve this problem.)

-- Relation schemas and instances for assignment 1
 
CREATE TABLE Student(sid integer,
                     sname text,
                     homeCity text,
                     primary key (sid));

CREATE TABLE Department(deptName text,
                        mainOffice text,
                        primary key (deptName));

CREATE TABLE Major(major text,
                   primary key (major));


CREATE TABLE employedBy(sid integer,
                        deptName text,
                        salary integer,
                        primary key (sid),
                        foreign key (sid) references Student (sid),
                        foreign key (deptName) references Department(deptName));


CREATE TABLE departmentLocation(deptName text,
                                building text,
                                primary key (deptName, building),
                                foreign key (deptName) references Department (deptName));


CREATE TABLE studentMajor(sid integer,
                          major text,
                          primary key (sid, major),
                          foreign key (sid) references Student (sid),
                          foreign key (major) references Major (major));


CREATE TABLE hasFriend(sid1 integer,
                       sid2 integer,
                       primary key(sid1,sid2),
                       foreign key (sid1) references Student (sid),
                       foreign key (sid2) references Student (sid));


INSERT INTO Student VALUES
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


INSERT INTO Department VALUES
     ('CS', 'LuddyHall'),
     ('DataScience', 'LuddyHall'),
     ('Mathematics', 'RawlesHall'),
     ('Physics', 'SwainHall'),
     ('Biology', 'JordanHall'),
     ('Chemistry', 'ChemistryBuilding'),
     ('Astronomy', 'SwainHall');


INSERT INTO employedBy VALUES
     (1001,'CS', 65000),
     (1002,'CS', 45000),
     (1003,'DataScience', 55000),
     (1004,'DataScience', 55000),
     (1005,'Mathematics', 60000),
     (1006,'DataScience', 55000),
     (1007,'Physics', 50000),
     (1008,'DataScience', 50000),
     (1009,'CS',60000),
     (1010,'DataScience', 55000),
     (1011,'Mathematics', 70000), 
     (1012,'CS', 50000),
     (1013,'Physics', 55000),
     (1014,'CS', 50000), 
     (1015,'DataScience', 60000),
     (1016,'DataScience', 55000),
     (1017,'Physics', 60000),
     (1018,'CS', 50000),
     (1019,'Biology', 50000);

INSERT INTO departmentLocation VALUES
   ('CS', 'LindleyHall'),
   ('DataScience', 'LuddyHall'),
   ('DataScience', 'Kinsey'),
   ('DataScience', 'WellsLibrary'),
   ('Mathematics', 'RawlesHall'),
   ('Physics', 'SwainHall'),
   ('Physics', 'ChemistryBuilding'),
   ('Biology', 'JordanHall'),
   ('CS', 'LuddyHall'),
   ('Mathematics', 'SwainHall'),
   ('Physics', 'RawlesHall'),
   ('Biology', 'MultiDisciplinaryBuilding'),
   ('Chemistry', 'ChemistryBuilding');

INSERT INTO Major VALUES
   ('CS'),
   ('DataScience'),
   ('Physics'),
   ('Chemistry'),
   ('Biology');

INSERT INTO studentMajor VALUES
 (1001,'CS'),
 (1001,'DataScience'),
 (1002,'CS'),
 (1002,'DataScience'),
 (1004,'DataScience'),
 (1004,'CS'),
 (1005,'DataScience'),
 (1005,'CS'),
 (1005,'Physics'),
 (1006,'CS'),
 (1006,'Chemistry'),
 (1007,'Chemistry'),
 (1007,'CS'),
 (1009,'Chemistry'),
 (1009,'Physics'),
 (1010,'Physics'),
 (1011,'Physics'),
 (1011,'Chemistry'),
 (1011,'DataScience'),
 (1011,'CS'),
 (1012,'DataScience'),
 (1012,'Chemistry'),
 (1012,'CS'),
 (1013,'CS'),
 (1013,'DataScience'),
 (1013,'Chemistry'),
 (1013,'Physics'),
 (1014,'Chemistry'),
 (1014,'DataScience'),
 (1014,'Physics'),
 (1015,'CS'),
 (1015,'DataScience'),
 (1016,'Chemistry'),
 (1016,'DataScience'),
 (1017,'Physics'),
 (1017,'CS'),
 (1018,'DataScience'),
 (1019,'Physics');

INSERT INTO hasFriend VALUES
 (1001,1008),
 (1001,1012),
 (1001,1014),
 (1001,1019),
 (1002,1001),
 (1002,1002),
 (1002,1011),
 (1002,1014),
 (1002,1015),
 (1003,1004),
 (1004,1002),
 (1004,1003),
 (1004,1012),
 (1004,1013),
 (1004,1014),
 (1004,1019),
 (1005,1015),
 (1006,1003),
 (1006,1004),
 (1006,1006),
 (1007,1008),
 (1007,1013),
 (1007,1016),
 (1007,1017),
 (1008,1001),
 (1008,1007),
 (1008,1015),
 (1008,1019),
 (1009,1001),
 (1009,1005),
 (1009,1013),
 (1010,1008),
 (1010,1013),
 (1010,1014),
 (1011,1005),
 (1011,1009),
 (1011,1010),
 (1011,1011),
 (1012,1011),
 (1013,1002),
 (1013,1007),
 (1013,1018),
 (1014,1005),
 (1014,1006),
 (1014,1012),
 (1014,1017),
 (1015,1002),
 (1015,1003),
 (1015,1005),
 (1015,1011),
 (1015,1015),
 (1015,1018),
 (1016,1004),
 (1016,1006),
 (1016,1015),
 (1017,1013),
 (1017,1014),
 (1017,1019),
 (1018,1004),
 (1018,1007),
 (1018,1009),
 (1018,1010),
 (1018,1013),
 (1019,1001),
 (1019,1006),
 (1019,1008),
 (1019,1013);


-- Problem 1

-- Provide 4 conceptually different examples that illustrate how the
-- presence or absence of primary and foreign keys affect insert and
-- deletes in these relations.  To solve this problem, you will need to
-- experiment with the relation schemas and instances for this
-- assignment.  For example, you should consider altering primary keys
-- and foreign key constraints and then consider various sequences of
-- insert and delete operations.  You may need to change some of the
-- relation instances to observe the desired effects.  Certain inserts
-- and deletes should succeed but other should generate error
-- conditions.  (Consider the lecture notes about keys, foreign keys,
-- and inserts and deletes as a guide to solve this problem.)

/*
\qecho 'Problem 1 conceptual example 1'
INSERT INTO Department VALUES ('CS', 'SwainHall');

OUTPUT --->ERROR:  duplicate key value violates unique constraint "department_pkey"
DETAIL:  Key (deptname)=(CS) already exists.
SQL state: 23505


\qecho 'Problem 1 conceptual example 2'
INSERT INTO employedBy VALUES ('1001', 'CS', 10000);

OUTPUT--->ERROR:  duplicate key value violates unique constraint "employedby_pkey"
DETAIL:  Key (sid)=(1001) already exists.
SQL state: 23505

ERROR:  duplicate key value violates unique constraint "employedby_pkey"
DETAIL:  Key (sid)=(1001) already exists.
SQL state: 23505

\qecho 'Problem 1 conceptual example 3'
DELETE FROM Student WHERE sid = 1001;

Output -- >ERROR:  update or delete on table "student" violates foreign key constraint "employedby_sid_fkey" on table "employedby"
DETAIL:  Key (sid)=(1001) is still referenced from table "employedby".
SQL state: 23503

\qecho 'Problem 1 conceptual example 4'
DELETE FROM Major WHERE Major = 'CS';

Output-- ERROR:  update or delete on table "major" violates foreign key constraint "studentmajor_major_fkey" on table "studentmajor"
DETAIL:  Key (major)=(CS) is still referenced from table "studentmajor".
SQL state: 23503
*/


/*
INSERT INTO Department VALUES ('Physics', 'SwainHall');

ERROR:  duplicate key value violates unique constraint "department_pkey"
DETAIL:  Key (deptname)=(Physics) already exists.
SQL state: 23505

INSERT INTO employedBy VALUES ('1002', 'CS', 10000);

OUTPUT- -->ERROR:  duplicate key value violates unique constraint "employedby_pkey"
DETAIL:  Key (sid)=(1002) already exists.
SQL state: 23505

DELETE FROM Student WHERE sid = 1002;

ERROR:  update or delete on table "student" violates foreign key constraint "employedby_sid_fkey" on table "employedby"
DETAIL:  Key (sid)=(1002) is still referenced from table "employedby".
SQL state: 23503

DELETE FROM department WHERE deptname = 'CS';

ERROR:  update or delete on table "department" violates foreign key constraint "employedby_deptname_fkey" on table "employedby"
DETAIL:  Key (deptname)=(CS) is still referenced from table "employedby".
SQL state: 23503


*/


\qecho 'Problem 2'
-- Find each pair (d, m) where d is the name of a department and m is a
-- major of a student who is employed by that department and who earns a
-- salary of at least 20000.

Select distinct E.deptName,SM.major
FROM employedby E,studentmajor SM
WHERE E.sid=SM.sid AND E.salary >= 20000 ORDER BY E.deptName;




\qecho 'Problem 3'
-- Find each pair (s1,s2) of sids of different students who have the same
-- (set of) friends who work for the CS department.
-- Collaborated with Aditi Soni
SELECT st1.sid, st2.sid
FROM student st1, student st2
WHERE st1.sid <> st2.sid AND
NOT EXISTS(SELECT 1
           FROM hasfriend hf, employedby eb
           WHERE st1.sid = hf.sid1 and eb.sid = hf.sid2 and eb.deptname = 'CS'
           AND eb.sid NOT IN(
           SELECT hf.sid2
           FROM hasfriend hf, employedby eb
           WHERE st2.sid = hf.sid1 and eb.deptname = 'CS'
          )) AND
           NOT EXISTS (SELECT 1
           FROM hasfriend hf, employedby eb
           WHERE st2.sid = hf.sid1 and eb.sid = hf.sid2 and eb.deptname = 'CS'
           AND eb.sid NOT IN(
           SELECT hf.sid2
           FROM hasfriend hf, employedby eb
           WHERE st1.sid = hf.sid1 and eb.deptname = 'CS'
          ));





\qecho 'Problem 4'
-- Find each major for which there exists a student with that major and
-- who does not only have friends who also have that major.

select distinct sm.major from studentmajor sm,hasfriend hf1,hasfriend hf2,studentmajor smf1,studentmajor smf2
where hf1.sid1=sm.sid and smf1.sid=hf1.sid2 and sm.major=smf1.major and hf2.sid1=sm.sid and smf2.sid=hf2.sid2 and sm.major <> smf2.major;


\qecho 'Problem 13'

select s1.sid,s1.sname from student s1
where true=some (select d.deptName=w.deptname and s1.sid=w.sid and d.mainoffice='LuddyHall' from department d,employedby w)
and  true=some (select s2.homeCity <> 'Bloomington' and hf.sid1=s1.sid and hf.sid2=s2.sid from student s2,hasfriend hf);

/*true=all*/
select s1.sid,s1.sname from student s1
where not true=all (select d.deptName<>w.deptname or s1.sid<>w.sid or d.mainoffice<>'LuddyHall' from department d,employedby w)
and  not true =all (select s2.homeCity = 'Bloomington' or hf.sid1<>s1.sid or hf.sid2<>s2.sid from student s2,hasfriend hf);

/*exists*/
select s1.sid,s1.sname from student s1
where exists (select 1 from department d,employedby w where d.deptName=w.deptname and s1.sid=w.sid and d.mainoffice='LuddyHall')
and exists (select 1 from student s2,hasfriend hf where s2.homeCity <> 'Bloomington' and hf.sid1=s1.sid and hf.sid2=s2.sid);






\qecho 'Problem 14'
/*true=all */

select s1.sid from student s1
where true=all(select not(hf.sid1=s1.sid and hf.sid2 = s2.sid) or
              not true=all(select sm1.sid!=s1.sid or sm2.sid!=s2.sid or sm1.major!=sm2.major or sm1.sid =sm2.sid
                       from studentmajor sm1,studentmajor sm2)
              from student s2, hasfriend hf);
/* true=some*/

select s1.sid from student s1
where not true=some(select (hf.sid1=s1.sid and hf.sid2 = s2.sid) and
               not true=some(select sm1.sid=s1.sid and sm2.sid=s2.sid and sm1.major=sm2.major and sm1.sid !=sm2.sid
                       from studentmajor sm1,studentmajor sm2)
              from student s2, hasfriend hf);
              
/*exists*/

Select s1.sid
from student s1
where not exists (select 1
                  from student s2, hasfriend hf
                  where hf.sid1 = s1.sid AND hf.sid2 = s2.sid
                  and NOT EXISTS (select 1
                                  from studentmajor sm1, studentmajor sm2
                                  where sm1.sid = s1.sid AND sm2.sid = s2.sid
                                  and sm1.major = sm2.major AND sm1.sid <> sm2.sid));

              


\qecho 'Problem 15'
/*true=all*/
select s1.sid as sid1,s2.sid as sid2
from Student s2,student s1 where s1.sid <>s2.sid and true=all(select not (s1.sid=f1.sid1) or
not true=all(select f2.sid1!=s2.sid or f1.sid2 != f2.sid2 from hasfriend f2)
from hasfriend f1);

/*true=some*/
select  s1.sid as sid1,s2.sid as sid2
from Student s2,student s1 where s1.sid <>s2.sid and not true=some(select (s1.sid=f1.sid1) and
not true=some(select f2.sid1=s2.sid and f1.sid2 = f2.sid2 from hasfriend f2)
from hasfriend f1);

/*exists condition*/
select  s1.sid as sid1,s2.sid as sid2
from Student s2,student s1
where s1.sid <>s2.sid and not exists(select 1 from hasfriend f1 where s1.sid =f1.sid1 and
not exists (select 1 from hasfriend f2 where f2.sid1=s2.sid and f1.sid2 = f2.sid2));



\qecho 'Problem 22.b'
-- Some major has fewer than 2 students with that major.

select not true=all (select false from major m1
where m1.major not in (select distinct sm1.major
from studentMajor sm1
where not true = all (select ((sm1.major != sm2.major)
or (sm2.sid = sm1.sid))
from studentMajor sm2))) as boolean;


 


\qecho 'Problem 23.b'
-- Each student who works for a department has a friend who also works
-- for that department and who earns the same salary

select true=some (select true from department d1
        where not true = some (select deptName != d1.deptname
                    from employedBy f1
                    where not exists((select hf.sid1 != f1.sid
                                    from hasfriend hf
                                        where not true = all (select f1.salary != eb.salary or f1.deptname != eb.deptname
                                                        or f1.sid = eb.sid
                                                        or hf.sid2 != eb.sid
                                                                      from employedBy eb)))))
as booleanConstraint;
                                                                      
                                                                      


\qecho 'Problem 24.b'
-- All students working in a same department share a major and earn the
-- same salary.

select not true=some (select eb1.salary != eb2.salary or eb1.deptname != eb2.deptname
                   from employedby eb1,
                        employedby eb2
                   where (eb1.sid = eb2.sid)
                     or true = some
                         (select sm1.sid = eb1.sid and sm2.sid=eb2.sid and sm1.sid <> sm2.sid
                                     and sm1.major = sm2.major
                          from studentmajor sm1,
                               studentmajor sm2));


-- Connect to default database
-- \c postgres;

-- Drop database created for this assignment
-- DROP DATABASE dirkassignment;





