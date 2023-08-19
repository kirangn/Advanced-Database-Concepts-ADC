/* TEAM 18: Submitted by
1. Sravya Arutla
2. Kiran Naik
3. Aqsa 
4. Aditi
*/


create DATABASE dirkassignment4;

-- Connecting to database 
\c dirkassignment4

\qecho 'Problem 1'

-- Problem 1:
-- Develop appropriate insert and delete triggers that implement the primary
-- and foreign key constraints for the Person and Knows relations. If an insert
-- or delete cause a violation for such a constraints, your triggers should
-- report an appropriate error message.
-- For this problem, implement the triggers such that foreign key constraints
-- are maintained using the cascading delete semantics.
-- Provide test cases that show that your triggers work properly.

-- Creating the tables required for problem 1
CREATE TABLE Person(pid integer,
                    name text );

CREATE TABLE Knows(pid1 integer,
                   pid2 integer );

CREATE TABLE Company(cname text,
                     city text );

CREATE TABLE worksFor(pid integer,
                      cname text );

/* primary key constraint for Person table */
-- Trigger Function
CREATE OR REPLACE FUNCTION check_Person_primary_key_constraint_action()
RETURNS trigger AS
$$
BEGIN
IF NEW.pid IN (SELECT pid FROM Person) THEN
RAISE EXCEPTION 'pid already exists in the Person table';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Trigger Defination
CREATE TRIGGER check_Person_primary_key_constraint_definition
BEFORE INSERT ON Person
FOR EACH ROW EXECUTE PROCEDURE check_Person_primary_key_constraint_action();


/* primary key + FOREIGN KEY constraint for knows table */
-- Trigger Function
CREATE OR REPLACE FUNCTION check_Knows_key_constraint_action()
RETURNS trigger AS
$$
BEGIN
IF (NEW.pid1,NEW.pid2) IN (SELECT pid1,pid2 FROM Knows) THEN
RAISE EXCEPTION 'pid1, pid2 pair already exists in the knows table';
END IF;
IF NEW.pid1 NOT IN (SELECT PID FROM Person) THEN
RAISE EXCEPTION 'Foreign key constraint violation - Key pid1 is not present in table - Person';
END IF;
IF NEW.pid2 NOT IN (SELECT PID FROM Person) THEN
RAISE EXCEPTION 'Foreign key constraint violation - Key pid2 is not present in table - Person';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger Defination
CREATE TRIGGER check_Knows_key_constraint_definition
BEFORE INSERT ON Knows
FOR EACH ROW EXECUTE PROCEDURE check_Knows_key_constraint_action();


/* Cascade delete in person table */
-- Trigger Function
CREATE OR REPLACE FUNCTION check_Person_Foreign_key_constraint_delete_action()
RETURNS TRIGGER AS
$$
BEGIN
IF OLD.pid IN (SELECT pid1 FROM KNOWS) THEN
DELETE FROM KNOWS WHERE pid1 = OLD.pid;
END IF;
IF OLD.pid IN (SELECT pid2 FROM KNOWS) THEN
DELETE FROM KNOWS WHERE pid2 = OLD.pid;
END IF;
IF OLD.pid IN (SELECT pid FROM WORKSFOR) THEN
DELETE FROM WORKSFOR WHERE pid = OLD.pid;
END IF;
RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Trigger Defination
CREATE TRIGGER check_Person_Foreign_key_constraint_delete_definition
BEFORE DELETE ON PERSON
FOR EACH ROW
EXECUTE PROCEDURE check_Person_Foreign_key_constraint_delete_action();
		

/* TESTCASES for the above created triggers */

INSERT INTO PERSON VALUES (1001,'Madhav'),(1002,'Vidya'),(1003,'John'),(1004,'Sam'),(1005,'Rhea');

--below insert will fail because 1002 pid is already present and it violates the primary key constraint for Person table
INSERT INTO PERSON VALUES (1002,'Elan');

--Below INSERT will give an error message - Foreign key constraint violation - Key pid2 is not present in table - Person since 1008 is absent in person.
INSERT INTO KNOWS VALUES (1001,1008);

--below insert will be successful
INSERT INTO KNOWS VALUES (1001,1003),(1001,1004),(1002,1003),(1003,1004);

select * from knows;

--below insert will fail as primary key constraint violated for the below example 
--as (1001,1004) pair already exists in the table
INSERT INTO KNOWS VALUES (1001,1004);

--BELOW STATEMENT WILL DELETE ALL ENTRIES FROM KNOWS WHERE PID1=1004 OR PID2=1004
DELETE FROM PERSON WHERE PID = 1004;

--BELOW WILL RETURN ONLY 3 ROWS SINCE THERE WERE 2 ROWS CONTAINING 1004 WHICH WAS A FOREIGN KEY IN PERSON TABLE 
--SO IT HAS BEEN DELETED. 
select * from knows;

\qecho 'Problem 3'

-- Consider the following view definition
-- create or replace view PersonKnowsNumberofPersons as
-- (select p1.pid, p1.name,
-- (select count(1)
-- from Person p2
-- where (p1.pid, p2.pid) in (select k.pid1, k.pid2
-- from Knows k)) as ct_Knows_Persons
-- from Person p1);
-- This view defines the set of tuples (p, n, c) where p and n are the pid and
-- name of a person, and c is the number of persons who are known by the
-- person with pid p.
-- You should not create this view! Rather your task is to create a relation
-- PersonKnowsNumberofPersons that maintains a materialized view in accordance with the above view definition under insert and delete operations
-- on the Person and Knows relation.
-- Your triggers should be designed to be incremental. In particular, when
-- an insert or delete happens, you should not always have to reevaluate all
-- the numbers of persons known by persons. Rather the maintenance of
-- PersonKnowsNumberofPersons should only apply to the person information that is affected by the insert or delete.
-- Provide test cases that show that your triggers work properly.


CREATE TABLE PersonKnowsNumberofPersons (pid integer,name text ,ct_Knows_Persons integer);

--below trigger will add every new pid inserted to table person (ON INSERT) with initially ct_Knows_Persons = 0 
CREATE OR REPLACE FUNCTION add_to_knows_person_count_action()
RETURNS trigger AS
$$
BEGIN

INSERT INTO PersonKnowsNumberofPersons VALUES (NEW.pid, NEW.name, 0);

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER add_to_knows_person_count_definition
BEFORE INSERT ON Person
FOR EACH ROW EXECUTE PROCEDURE add_to_knows_person_count_action();

--below trigger will be activated on every new INSERT INTO KNOWS. 
--It will increament the corresponding pid1's count in our materialized view table.

CREATE OR REPLACE FUNCTION add_to_person_knows_person_count_action()
RETURNS trigger AS
$$
BEGIN

UPDATE PersonKnowsNumberofPersons SET ct_Knows_Persons = ct_Knows_Persons + 1 
WHERE PID = NEW.PID1;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER add_to_person_knows_person_count_definition
BEFORE INSERT ON KNOWS
FOR EACH ROW EXECUTE PROCEDURE add_to_person_knows_person_count_action();


--TESTCASES
DELETE FROM PERSON;
DELETE FROM KNOWS;


--INSERT NEW ROWS INTO PERSON
INSERT INTO PERSON VALUES (1001, 'Rama'),(1002,'Tammy'),(1003,'John'),(1004,'Sam'),(1005,'Kim'),(1006,'Seema');
--below we can see that our PersonKnowsNumberofPersons relation has been populated with the above pids and their count=0
select * from PersonKnowsNumberofPersons order by 1;


--INSERT NEW TUPLES IN KNOWS RELATION. This will trigger an update operation 
--in our PersonKnowsNumberofPersons relation and update the total count of people known by the different pid
INSERT INTO Knows VALUES
 (1001,1002),
 (1001,1003),
 (1001,1004),
 (1003,1004),
 (1002,1004),
 (1002,1003),
 (1002,1005),
 (1005,1006),
 (1006,1003),
 (1006,1001);
 
--below we can see that the count of people the persons(pids) know have been updated 
--in the PersonKnowsNumberofPersons relation
select * from PersonKnowsNumberofPersons order by 1;

--Testcase 2 INSERT NEW TUPLES IN KNOWS RELATION. This will trigger an update operation 
--in our PersonKnowsNumberofPersons relation and update the total count of people known by the different pid
INSERT INTO Knows VALUES
 (1004,1002),
 (1004,1003),
 (1004,1006),
 (1003,1002),
 (1003,1005),
 (1001,1006),
 (1002,1001),
 (1005,1001),
 (1006,1005),
 (1006,1002);
 
--successful output - below we can see that the count of people the persons(pids) know have been updated 
--in the PersonKnowsNumberofPersons relation
select * from PersonKnowsNumberofPersons order by 1;

--cascading delete. if a pid is deleted from person table then we need to delete corresponding record 
--from the PersonKnowsNumberofPersons relation

--below trigger will be activated when a pid is deleted from person table
CREATE OR REPLACE FUNCTION delete_from_knows_person_count_action()
RETURNS TRIGGER AS
$$
BEGIN
DELETE FROM PersonKnowsNumberofPersons WHERE pid = OLD.pid;
RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER delete_from_knows_person_count_definition
BEFORE DELETE ON Person
FOR EACH ROW
EXECUTE PROCEDURE delete_from_knows_person_count_action();

--below trigger will be activated when a tuple is deleted from knows table. 
--The count for pid1 will be decremented by 1
CREATE OR REPLACE FUNCTION delete_from_person_knows_person_count_action()
RETURNS TRIGGER AS
$$
BEGIN

UPDATE PersonKnowsNumberofPersons SET ct_Knows_Persons = ct_Knows_Persons - 1
where pid = OLD.pid1;

RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER delete_from_person_knows_person_count_definition
BEFORE DELETE ON Knows
FOR EACH ROW
EXECUTE PROCEDURE delete_from_person_knows_person_count_action();

--testcases
--delete from knows and check the count in the relation 
--before delete
select * from PersonKnowsNumberofPersons order by 1;
--delete from knows table pid1=1001
delete from knows where pid1 = 1001 and pid2=1002;
--after delete we can see the count for pid=1001 has reduced by 1
select * from PersonKnowsNumberofPersons order by 1;

--testcase2
--delete from knows table pid1=1002
delete from knows where pid1 = 1002 and pid2=1005;
--after delete we can see the count for pid=1002 has reduced by 1
select * from PersonKnowsNumberofPersons order by 1;
 
 

--below is a testcase showing that when a pid is deleted from person then corresponding entry 
--in the PersonKnowsNumberofPersons is also deleted
delete from person where pid = 1006;

--after delete we can see that the entry for 1006 has been deleted from the relation
--Also, since 1006 was deleted it had a cascading effect on Knows relation due to the trigger defined above
--All the tuples with pid = 1006 were deleted from knows which activated the trigger to decrement the count
--of people who knew 1006. This is a great example to see that all the triggers are working in the desired manner.

select * from PersonKnowsNumberofPersons order by 1;


DROP TABLE Company;
DROP TABLE worksFor;


\qecho 'Problem 2'

-- Develop a trigger for the constraint that states that each cname in worksFor
-- must references a cname in Company. Since the trigger resembles a foreign
-- key constraints, use the cascade delete semantics for its implementation.
-- Provide test cases that show that your triggers work properly.

-- Creating the tables for Problem 2
CREATE TABLE Company(cname text,
                     city text );

CREATE TABLE worksFor(pid integer,
                      cname text );

\qecho 'Trigger inserting the unique values to the company table'

-- Trigger  for inserting the unique values to the company table

CREATE OR REPLACE FUNCTION check_cname_city_constraint_action()
RETURNS trigger AS
$$
BEGIN
	IF (NEW.cname,NEW.city) IN (SELECT cname,city FROM company) THEN
	RAISE EXCEPTION 'cname % already exists with same city %',NEW.cname,NEW.city;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger creation on Company table

CREATE TRIGGER check_Primary_Key_definition
BEFORE INSERT ON Company
FOR EACH ROW
EXECUTE PROCEDURE check_cname_city_constraint_action();


--Insert Values for Company table

INSERT INTO Company VALUES
   ('Apple', 'Bloomington'),
   ('Amazon', 'Chicago');

-- Test values for existing cname and city in Company table

INSERT INTO Company VALUES
   ('Apple', 'Bloomington');

-- Test values for existing cname and not same city in Company table

INSERT INTO Company VALUES
   ('Apple', 'NewYork');

-- Company table
\qecho 'After inserting values to company table'

select * FROM Company;

\qecho 'Trigger for inserting  values to worksfor table that are present in company'

-- Trigger for worksfor table to check while inserting cname to the worksfor table, checks if the cname present in the Company table


CREATE OR REPLACE FUNCTION check_cname_constraint_action()
RETURNS trigger AS
$$
BEGIN
	IF NEW.cname not IN (SELECT cname FROM company) THEN
	RAISE EXCEPTION 'cname % does not exist in the company table ',NEW.cname;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger definition

CREATE TRIGGER check_foreign_Key_definition
BEFORE INSERT ON worksfor
FOR EACH ROW
EXECUTE PROCEDURE check_cname_constraint_action();


-- Test case for Insert values for worksfor

INSERT INTO worksFor VALUES
     (1001,'Apple');

--  Test case for Insert values for worksfor when the cname is not present in the Company table
	 
INSERT INTO worksFor VALUES	 
	 (1005,'Google');

-- Select for the worksfor  Relation
\qecho 'After inserting valid values to worksfor table'
select * FROM worksfor;



-- Delete from company should also delete the entry in the worksfor table
\qecho 'Trigger for delete function'

CREATE OR REPLACE FUNCTION delete_cascade_constraint_action()
RETURNS trigger AS
$$
BEGIN
	IF OLD.cname IN (SELECT cname FROM worksfor) THEN
		DELETE FROM worksfor WHERE cname = OLD.cname;
	END IF;
	
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Trigger delete
CREATE TRIGGER Delete_foreign_Key_definition
BEFORE DELETE ON company
FOR EACH ROW
EXECUTE PROCEDURE delete_cascade_constraint_action();


--Test case to delete the cname from company and works for
DELETE FROM Company WHERE cname = 'Amazon'
\qecho 'After deleting values to company table, which also impact the worksfor'
select * from Company;

select * from worksfor;


\qecho 'Problem 4'

-- The Student, Prerequisite, and hasTaken are relations that are immutable. No inserts, deletes, or updates, are permitted on these relations. For these relations, no triggers need to be developed.
-- The attributes cno, cname, max in Course are immutable. On the other
-- hand, the attribute total in Course is mutable: it can increase or decrease. At any time, during insert or delete operation on the Enroll and
-- waitList relations, this attribute has as values the current total number
-- of students who have enrolled in the affected courses.
-- Inserts and deletes are permitted on the Enroll and Waitlist relations.
-- These insert and delete operations are governed by the following rules:


-- Relation for Student Data

create table student(sid int,sname text,major text,
					primary key(sid));
					
create table course( cno int,cname text,total int,max int,primary key (cno));

create table Prerequisite(cno int,prereq int,
						  foreign key (cno) references course (cno),
						 foreign key (prereq) references course (cno));

create table hasTaken(sid int,cno int,
					 foreign key (cno) references course (cno),
					 foreign key (sid) references student (sid));
					 
create table enroll(sid int,cno int);

create table waitlist(sid int,cno int,position int);


Insert into student values
(1001,'Tony','CS'),
(1002,'Stark','DS'),
(1003,'Steve','CS'),
(1004,'Vision','DS'),
(1005,'Hulk','CS'),
(1006,'Scarlet','CS');

Insert into course values
(1,'AML',0,5),
(2,'Usability',0,3),
(3,'DeepLearning',0,4),
(4,'CN',0,2);

Insert into prerequisite VALUES
(1,2),
(2,1),
(3,4),
(4,3),
(1,3);

Insert INTO hastaken VALUES
(1001,2),
(1002,1),
(1002,4),
(1003,3),
(1005,3),
(1006,3),
(1003,1),
(1005,1),
(1006,1),
(1004,1),
(1004,3);

\qecho 'Problem 4a'

--  A student can only enroll in a course if he or she has taken all the
-- prerequisites for that course. If the enrollment succeeds, the total
-- enrollment value for that course needs to be incremented by 1 provided that this increment does lead to a value that exceed the max
-- enrollment value for that course.


-- Trigger Function
CREATE OR REPLACE FUNCTION Enroll_Students_action()
RETURNS trigger AS
$$
Declare _pos int;
BEGIN
	IF NEW.sid not in (Select sid from Student) Then
	Raise Exception '% is not in Student Table',New.sid;
	End If;
	IF NEW.cno not in (Select cno from Course) Then
	Raise Exception '% is not in Course Table',New.cno;
	End If;
	IF (NEW.sid,NEW.cno) IN (SELECT sid,cno FROM enroll) THEN
	RAISE EXCEPTION 'sid % already exists with same cno % in table Enroll',NEW.sid,NEW.cno;
	END IF;
	IF FALSE IN (select prereq in (SELECT cno FROM hastaken where sid=NEW.sid) from prerequisite where cno=New.cno) THEN
	RAISE EXCEPTION 'Required Prequesites for course no % are not meeting for sid %',New.cno,NEW.sid;
	END IF;
	IF (select total+1 from course where cno=New.cno) <= (select max from course where cno=New.cno) THEN
	UPDATE course SET total = total + 1 WHERE cno=New.cno;
	RETURN NEW;
	END IF; 
    -- waitlist addition condition which calls the waitlist trigger described below
	IF (select total+1 from course where cno=New.cno) > (select max from course where cno=New.cno) THEN
	_pos = (select count(position)from waitlist where cno=New.cno);
	insert into waitlist values(NEW.sid,New.Cno,_pos+1);
	Raise Info '% added to waitlist',NEW.cno;
	RETURN NULL;
	END IF;
END;
$$ LANGUAGE plpgsql;

-- Trigger Defination
CREATE TRIGGER Enroll_Definition
BEFORE INSERT ON ENROLL
FOR EACH ROW
EXECUTE PROCEDURE Enroll_Students_action();

-- Testcases for enroll table

insert into enroll values(1001,1); -- The course that has Multiple prerequisites to be completed for enrolment
insert into enroll values(1002,3); -- prerequisites approved
insert into enroll values(1005,4);
insert into enroll values(1006,4);
insert into enroll values(1002,3); -- sid exists  for same course in enroll table.

insert into enroll values(1020,2); -- Sid is not present in the student table
insert into enroll values(1002,20); -- cno is not present in Course table

-- Trigger for waitlist table

CREATE OR REPLACE FUNCTION Waitlist_Students_action()
RETURNS trigger AS
$$
BEGIN
	IF (NEW.sid,NEW.cno) IN (SELECT sid,cno FROM waitlist) THEN
	RAISE Exception 'sid % already exists with same cno % in table Waitlist',NEW.sid,NEW.cno;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER Waitlist_Definition
BEFORE INSERT ON Waitlist
FOR EACH ROW
EXECUTE PROCEDURE Waitlist_Students_action();

\qecho 'Problem 4b -Testcase'
--  A student can only enroll in a course if his or her enrollment does
-- not exceed the maximum enrollment for that course. However, the
-- student must then be placed at the next available position on the
-- waitlist for that course.

-- Test cases for waitlist which will call enroll and the waitlist table

insert into enroll values(1003,4); -- for waitlist adding
insert into enroll values(1003,4); -- duplicate check on waitlist


\qecho 'Course table after an enroll and waitlist'

Select * from enroll;
Select * from waitlist;

\qecho 'Problem 4c'
--  A student may disenroll from course, either by removing him or herself from the Waitlist or from the Enroll relation. When the latter
-- happens and if there are students on the waitlist for that course, then
-- the student who is at the first position for that course on the waitlist
-- gets enrolled in that course and removed from the waitlist. If there
-- are no students on the waitlist, then the total enrollment for that
-- course needs to decrease by 1.

-- Delete happens for specific sid and cno
CREATE OR REPLACE FUNCTION delete_enroll_constraint_action()
RETURNS trigger AS
$$
Declare sidno int;
DECLARE courseno int;
DECLARE f record;
BEGIN

		IF OLD.cno in (select cno from waitlist) THEN
			Update course Set total =total-1 where cno=Old.cno;
			Select sid,cno,position INTO sidno,courseno from waitlist where cno=old.cno order by position LIMIT 1;
			DELETE FROM waitlist WHERE cno = OLD.cno and sid = sidno;
			Insert into enroll values(sidno,courseno);
		ELSE
			Update course Set total =total-1 where cno=Old.cno;
		END IF;

	
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Trigger delete
CREATE TRIGGER Delete_enroll_definition
After DELETE ON Enroll
FOR EACH ROW
EXECUTE PROCEDURE delete_enroll_constraint_action();

--Test Case for deleting from enroll

-- Adding some enroll entries 

insert into enroll values(1003,2);
insert into enroll values(1005,2);
insert into enroll values(1006,2);
insert into enroll values(1004,2);
insert into enroll values(1004,4);

select * from Enroll;

select * from waitlist;

\qecho 'Execute delete for sid 1006 and cno =4 '

Delete from enroll where sid=1006 and cno=4;

\qecho 'After deleting the sid =1006, the waitlist position for sid 1003 is vanished and added to the enroll table as there was vacant postion'

select * from waitlist;
select * from enroll;

\qecho 'Delete the course no =3 and sid =1002, should only update the total in course, as this course still has some vacancy in the enrollment'
 
Delete from enroll where sid=1002 and cno=3;

\qecho 'After deleting the sid =1002, the course  and enroll table look like this'

select * from enroll;
select * from course;


-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE dirkassignment4;