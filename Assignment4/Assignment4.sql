CREATE DATABASE dvgassignment4_sam;

-- Connecting to database 
\c dvgassignment4_sam

-- Relation schemas and instances for assignment 4

CREATE TABLE Person(pid integer,
                    name text);


CREATE TABLE Company(cname text,
                     city text);

CREATE TABLE worksFor(pid integer,
                      cname text);

CREATE TABLE Knows(pid1 integer,
                   pid2 integer);

\qecho 'Problem 2'
-- Question 2
/* Develop a trigger for the constraint that states that each cname in worksFor
must references a cname in Company. Since the trigger resembles a foreign
key constraints, use the cascade delete semantics for its implementation.
Provide test cases that show that your triggers work properly.
*/

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




\qecho 'Question4'

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

-- Test cases for waitlist which will call enroll and the waitlist table

insert into enroll values(1003,4); -- for waitlist adding
insert into enroll values(1003,4); -- duplicate check on waitlist


\qecho 'Course table after an enroll and waitlist'

Select * from enroll;
Select * from waitlist;

\qecho 'Problem 4c'


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
DROP DATABASE dvgassignment4_sam;