-- Script for Assignment 5  Fall 2022

-- Team 18
-- Aditi Soni
-- Aqsa Bhimdiwala
-- Kiran Gurunath Naik
-- Sravya Arutla

-- Creating database with full name

CREATE DATABASE dvgfall2022assignment5_1;


-- Connecting to database 
\c dvgfall2022assignment5_1

-- Relation schemas and instances for assignment 5


CREATE TABLE Student(sid integer,
                     sname text,
                     birthYear integer,
                     primary key (sid));

CREATE TABLE Book(bno integer,
                  title text,
                  price integer,
                  primary key (bno));

CREATE TABLE Major(major text,
                   primary key (major));


CREATE TABLE Buys(sid integer,
                  bno integer,
                  primary key (sid,bno),
                  foreign key (sid) references Student(sid),
                  foreign key (bno) references Book(bno));


CREATE TABLE hasMajor(sid integer,
                      major text,
                      primary key (sid, major),
                      foreign key (sid) references Student (sid),
                      foreign key (major) references Major (major));


CREATE TABLE Cites(bno1 integer,
                   bno2 integer,
                   primary key (bno1,bno2),
                   foreign key (bno1) references Book(bno),
                   foreign key (bno2) references Book(bno));



INSERT INTO Student VALUES
 (1001,'Jean',1999),
 (1002,'Vidya',1999),
 (1003,'Anna',2001),
 (1004,'Qin',2001),
 (1005,'Megan',1999),
 (1006,'Ryan',1995),
 (1007,'Danielle',1997),
 (1008,'Emma',2000),
 (1009,'Hasan',2000),
 (1010,'Linda',1995),
 (1011,'Nick',1999),
 (1012,'Eric',1999),
 (1013,'Lisa',1998),
 (1014,'Deepa',2000),
 (1015,'Chris',1998),
 (1016,'YinYue',1995),
 (1017,'Latha',1997),
 (1018,'Arif',2000),
 (1019,'John',2003),
 (1020,'Margaret',1997);


INSERT INTO Book VALUES
 (2001,'Databases',20),
 (2002,'AI',20),
 (2003,'DataScience',25),
 (2004,'Databases',25),
 (2005,'Programming',30),
 (2006,'Complexity',30),
 (2007,'AI',20),
 (2008,'Algorithms',40),
 (2009,'Networks',40),
 (2010,'AI',30),
 (2011,'Logic',25),
 (2012,'Physics',45),
 (2013,'Physics',30);



INSERT INTO Buys VALUES
 (1003,2001),
 (1010,2007),
 (1011,2010),
 (1014,2007),
 (1010,2005),
 (1011,2003),
 (1008,2006),
 (1009,2003),
 (1006,2003),
 (1007,2008),
 (1017,2004),
 (1017,2003),
 (1004,2001),
 (1007,2006),
 (1005,2007),
 (1005,2011),
 (1013,2004),
 (1002,2009),
 (1009,2011),
 (1018,2011),
 (1015,2004),
 (1001,2011),
 (1013,2006),
 (1015,2002),
 (1005,2002),
 (1008,2009),
 (1014,2009),
 (1002,2002),
 (1001,2002),
 (1009,2001),
 (1006,2006),
 (1015,2007),
 (1019,2008),
 (1006,2002),
 (1018,2008),
 (1003,2004),
 (1006,2011),
 (1013,2005),
 (1003,2010),
 (1008,2008),
 (1007,2009),
 (1016,2008),
 (1011,2002),
 (1004,2005),
 (1004,2009),
 (1006,2010),
 (1001,2010),
 (1001,2006),
 (1009,2010),
 (1019,2002),
 (1004,2010),
 (1018,2010),
 (1009,2006),
 (1008,2003),
 (1018,2005),
 (1004,2002),
 (1011,2004),
 (1007,2002),
 (1015,2005),
 (1012,2001),
 (1017,2010),
 (1002,2001),
 (1016,2010),
 (1010,2003),
 (1003,2008),
 (1017,2005),
 (1016,2006),
 (1011,2007),
 (1006,2009),
 (1001,2005),
 (1007,2005),
 (1005,2004),
 (1013,2008),
 (1005,2008),
 (1004,2011),
 (1009,2009),
 (1013,2001),
 (1015,2006),
 (1003,2002),
 (1016,2001),
 (1006,2007),
 (1016,2011),
 (1006,2008),
 (1007,2003),
 (1015,2003),
 (1011,2011),
 (1010,2006),
 (1012,2009),
 (1001,2001),
 (1011,2001),
 (1013,2002),
 (1012,2007),
 (1002,2010),
 (1012,2010),
 (1001,2007),
 (1005,2003),
 (1011,2005),
 (1014,2011),
 (1011,2006),
 (1009,2002),
 (1008,2001),
 (1002,2003),
 (1002,2005),
 (1009,2008),
 (1008,2002),
 (1006,2001),
 (1008,2007),
 (1012,2002),
 (1017,2008),
 (1019,2009),
 (1010,2010),
 (1003,2011),
 (1017,2006),
 (1013,2011),
 (1006,2004),
 (1016,2004),
 (1019,2001),
 (1002,2006),
 (1018,2006),
 (1010,2009),
 (1010,2008),
 (1003,2007),
 (1009,2007),
 (1002,2007),
 (1018,2009),
 (1004,2004),
 (1018,2001),
 (1007,2001),
 (1004,2003),
 (1010,2001),
 (1008,2010),
 (1008,2005),
 (1015,2001),
 (1012,2003),
 (1005,2006),
 (1007,2010),
 (1010,2004),
 (1015,2010),
 (1017,2002),
 (1013,2003),
 (1001,2008),
 (1016,2002),
 (1005,2005),
 (1016,2009),
 (1012,2004),
 (1009,2004),
 (1020,2012),
 (1020,2013);



INSERT INTO Major VALUES
   ('CS'),
   ('DataScience'),
   ('Math'),
   ('Physics'),
   ('Chemistry'),
   ('English');

INSERT INTO hasMajor VALUES
 (1001,'CS'),
 (1001,'DataScience'),
 (1002,'CS'),
 (1002,'DataScience'),
 (1004,'DataScience'),
 (1004,'CS'),
 (1005,'DataScience'),
 (1005,'CS'),
 (1005,'Math'),
 (1006,'CS'),
 (1006,'Physics'),
 (1007,'Physics'),
 (1007,'CS'),
 (1009,'Physics'),
 (1009,'Math'),
 (1010,'Math'),
 (1011,'Math'),
 (1011,'Physics'),
 (1011,'DataScience'),
 (1011,'CS'),
 (1012,'DataScience'),
 (1012,'Physics'),
 (1012,'CS'),
 (1013,'CS'),
 (1013,'Physics'),
 (1013,'Math'),
 (1014,'Physics'),
 (1014,'DataScience'),
 (1014,'Math'),
 (1015,'CS'),
 (1015,'DataScience'),
 (1016,'Physics'),
 (1016,'DataScience'),
 (1017,'Math'),
 (1017,'CS'),
 (1018,'DataScience'),
 (1019,'Math'),
 (1020,'Chemistry');


INSERT INTO Cites VALUES
 (2004,2003),
 (2006,2003),
 (2009,2003),
 (2009,2004),
 (2009,2006),
 (2008,2007),
 (2010,2008),
 (2010,2007),
 (2010,2003),
 (2002,2001),
 (2009,2001),
 (2011,2003),
 (2011,2005),
 (2001,2004),
 (2012,2013);

create or replace view studentBuysBooks as
   select sid, array(select t.bno
                     from   Buys t
      	      	     where  t.sid = s.sid order by 1) as books
   from   Student s order by 1;

create or replace view bookBoughtByStudents as
   select bno, array(select t.sid
                     from   Buys t
      	      	     where  t.bno = b.bno order by 1) as students
   from   Book b order by 1;


create or replace view studentHasMajors as
   select sid, array(select hm.major
                     from   hasMajor hm
      	      	     where  hm.sid = s.sid order by 1) as majors
   from   Student s order by 1;


create or replace view majorOfStudents as
   select major, array(select hm.sid
                       from   hasMajor hm
      	      	       where  hm.major = m.major order by 1) as students
   from   Major m order by 1;


create or replace view bookCitesBooks as
   select bno, array(select c.bno2
                     from   Cites c
      	      	     where  c.bno1 = b.bno order by 1) as citedBooks
   from   Book b order by 1;


create or replace view bookCitedByBooks as
   select bno, array(select c.bno1
                     from   Cites c
      	      	     where  c.bno2 = b.bno order by 1) as citingBooks
   from   Book b order by 1;

-- We define the following functions and predicates

/*
Functions:
set_union(A,B)               A union B
set_intersection(A,B)        A intersection B
set_difference(A,B)          A - B
add_element(x,A)             {x} union A
remove_element(x,A)          A - {x}
make_singleton(x)            {x}
bag_to_set(A)                coerce a bag A to the corresponding set

Predicates:
is_in(x,A)                   x in A
is_not_in(x,A)               not(x in A)
is_empty(A)                  A is the emptyset
is_not_emptyset(A)           A is not the emptyset
subset(A,B)                  A is a subset of B
superset(A,B)                A is a super set of B
equal(A,B)                   A and B have the same elements
overlap(A,B)                 A intersection B is not empty
disjoint(A,B)                A and B are disjoint 
*/

-- Set Operations: union, intersection, difference

-- Set union $A \cup B$:
create or replace function set_union(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) union select unnest(B) order by 1);
$$ language sql;

-- Set intersection $A\cap B$:
create or replace function set_intersection(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) intersect select unnest(B) order by 1);
$$ language sql;

-- Set difference $A-B$:
create or replace function set_difference(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) except select unnest(B) order by 1);
$$ language sql;


-- Add element to set
create or replace function add_element(x anyelement, A anyarray) 
returns anyarray as
$$
   select bag_to_set(x || A);
$$ language sql;


-- Remove element from set
create or replace function remove_element(x anyelement, A anyarray) 
returns anyarray as
$$
   select array_remove(A, x);
$$ language sql;


-- Make singleton  x --->  {x}

create or replace function make_singleton(x anyelement) 
returns anyarray as
$$
   select add_element(x,'{}');
$$ language sql;


-- Bag operations

-- Bag union 
create or replace function bag_union(A anyarray, B anyarray) 
returns anyarray as
$$
   select A || B;
$$ language sql;

-- bag To set
create or replace function bag_to_set(A anyarray)
returns anyarray as
$$
   select array(select distinct unnest(A) order   by 1);
$$ language sql;


-- Set Predicates: set membership, set non membership, emptyset, subset, superset, overlap, disjoint

-- Set membership $x \in A$:
create or replace function is_in(x anyelement, A anyarray) 
returns boolean as
$$
   select x = SOME(A);
$$ language sql;

-- Set non membership $x \not\in A$:
create or replace function is_not_in(x anyelement, A anyarray) 
returns boolean as
$$
   select not(x = SOME(A));
$$ language sql;

-- emptyset test $A = \emptyset$:
create or replace function is_empty(A anyarray) 
returns boolean as
$$
   select A <@ '{}';
$$ language sql;


-- non emptyset test $A \neq \emptyset$:
create or replace function is_not_empty(A anyarray) 
returns boolean as
$$
   select not(A <@ '{}');
$$ language sql;

-- Subset test $A\subseteq B$:
create or replace function subset(A anyarray, B anyarray) 
returns boolean as
$$
   select A <@ B;
$$ language sql;

-- Superset test $A \supseteq B$:
create or replace function superset(A anyarray, B anyarray) 
returns boolean as
$$
   select A @> B;
$$ language sql;

-- Equality test $A = B$
create or replace function equal(A anyarray, B anyarray) 
returns boolean as
$$
   select A <@ B and A @> B;
$$ language sql;

-- Overlap test $A\cap B \neq \emptyset$:
create or replace function overlap(A anyarray, B anyarray) 
returns boolean as
$$
   select A && B;
$$ language sql;

-- Disjointness test $A\cap B = \emptyset$:
create or replace function disjoint(A anyarray, B anyarray) 
returns boolean as
$$
   select not A && B;
$$ language sql;



\qecho 'Problem 1'

-- Find the sid and name of each student who bought the most books.

--referred Prof. notes

with E as (select (CARDINALITY ((select sB.books
				from studentBuysBooks sB 
 			 	where sB.sid = s.sid)))as bookcount
				from student s)	
				
select sid,sname
from student s 
where CARDINALITY((select sB.books
                    from   studentBuysBooks sB
                    where  sB.sid = s.sid)) = (select max(E.bookcount) from E);
	
	

\qecho 'Problem 2'

-- Find the sid and name of each student who bought the most books
-- that cost strictly more than $25.

with book_25 as
(select p.sid ,cardinality(array_agg(p.book_no)) as bookcount_25 from book b,
(select sid, unnest(books) as book_no from studentbuysbooks sB) p 
 where b.bno=p.book_no and b.price>25 group by (p.sid) )

select s.sid,s.sname from student s, book_25 
where s.sid =book_25.sid and book_25.bookcount_25 = (select max(bookcount_25) from book_25) order by 1;




\qecho 'Problem 3'

-- Find the bno and title of each book that is bought by a student who is
-- (strictly) younger than each student who majors in Chemistry and who
-- also bought that book.

with F as (
select s.birthyear from student s where IS_IN(s.sid,(select sM.students from majorofstudents sM where
																				  sM.major='Chemistry'))
)
select distinct b.bno,b.title 
from book b,student s
where IS_IN(b.bno,(select sb.books 
				 from studentbuysbooks sb where sb.sid=s.sid and s.birthyear > (select F.birthyear from F)))
				ORDER by 1;


\qecho 'Problem 4'

-- Find each student-book pair (s, b) where s is the sid of a student who
-- majors in CS and who bought each book that costs no more than book b.

select q.bno,p.sid_1 from (select unnest(sM.students) as sid_1 from majorOfStudents sM where sM.major='CS') P,
(select bs.bno,unnest(bs.students) as book_sid  from bookboughtbystudents bs )q where q.book_sid=p.sid_1 
and not exists (select 1
			   from book b
			   where b.price <=(select b1.price
							  from book b1
							  where b1.bno = q.bno) and not true=some
				(select r.b1_books= b.bno and r.sid = p.sid_1 from 
				 (select sid,unnest(books) as b1_books from studentbuysbooks) r
			   ));


\qecho 'Problem 5'

-- Find the bno and title of each book that cites a book and that was
-- bought by a student who majors in CS but not in Math.

with CSNotMath as (
    select distinct shm.sid
    from studentHasMajors shm
    where SUBSET('{"CS"} ',shm.majors)
    and not SUBSET('{"Math"}', shm.majors)
   )

select b.bno,
    b.title
from book b
where true = some(
        select IS_IN(b.bno, citingBooks)
        from bookcitedbybooks
    )
    and true = some(
        select IS_IN(b.bno, sbb.books)
        from studentBuysBooks sbb
        where true=some (
        select IS_IN(sbb.sid, ARRAY(select sid from CSNotMath))
        )
    )
order by 1;


\qecho 'Problem 6'

-- Find each (s, b) pair where s is the sid of a student who bought book
-- b and such that each other book bought by s is a book cited by b.

select distinct s.sid,
    b.bno
from student s,
    book b,
    bookCitesBooks bb,
    studentBuysBooks sb
WHERE bb.bno = b.bno
    and sb.sid = s.sid
    and IS_IN(b.bno, sb.books)
    and  equal(
        set_intersection(bb.citedBooks, sb.books),
        remove_element(b.bno, sb.books)
   )
   order by 1;


\qecho 'Problem 7'

-- Find each major that is not a major of any person who bought a book
-- with title ‘Databases’ or ‘Complexity’.

with DOrC as (
    select distinct sbb.sid
    from studentBuysBooks sbb
    where true = some (
            select IS_IN(b.bno, sbb.books)
            from book b
            where b.title = 'Databases'
                or b.title = 'Complexity'
        )
)
select m.major
from Major m
where true = all (
        select IS_NOT_IN(m.major, shm.majors)
        from studentHasMajors shm,DOrC b
        where b.sid = shm.sid
    )
order by 1;

\qecho 'Problem 8'

-- Find each major that is the major of at least three students who bought
-- a common book.

Select distinct m.major
FROM major m,
    bookBoughtByStudents bbs,
    majorOfStudents ms
WHERE ms.major = m.major
    AND CARDINALITY(set_intersection(bbs.students, ms.students)) >= 3
order by 1;


\qecho 'Problem 9'

-- Find each student who has no major in common with those of students
--  who bought a book with title ’Databases’ or ’AI’.


with DBandAIBooks as (SELECT ARRAY( SELECT UNNEST(bs.students)
 									FROM bookBoughtByStudents bs, Book b 
 									WHERE (bs.bno = b.bno and b.title = 'Databases') or
									(bs.bno = b.bno and b.title = 'AI')) AS selectedStudents),
			majorSbb as (SELECT ARRAY(SELECT UNNEST(shm.majors) 
        FROM studentHasMajors shm, DBandAIBooks bk
        WHERE is_in( shm.sid, bk.selectedStudents)
    ) as majorArray),
	noMajor as (select array( select distinct shm.sid
				from studentHasMajors shm
				where is_empty(shm.majors)) as studentwNoMajor),
				notsameMajor as (select array (SELECT distinct unnest (ms.students)
from majorOfStudents ms, majorSbb x
where is_not_in(ms.major, x.majorArray)) as notSame)
			

select unnest(p.*) as "sid"
from set_union((select studentwNoMajor
			   from noMajor), (select notSame from notSameMajor))p;
            

\qecho 'Problem 10'

-- Find the set of bnos of books that each cite strictly more than 4
-- books and that each are cited by fewer than 2 books. (So this query
-- returns only one object, i.e., the set of bnos specified in the
-- query.)


WITH CitedFewerThan2 as ( Select array(select distinct bcb.bno
									   from bookcitedbybooks bcb
									   where cardinality(bcb.citingBooks) < 2 ) as arr2),
			 CiteMoreThan4 as (select array (select distinct bb.bno
									from bookcitesbooks bb
									where cardinality (bb.citedBooks) > 4) as arr4 )


select books.* 
from set_intersection((select arr2 from CitedFewerThan2), (select arr4 from CiteMoreThan4))books;


--If we consider the condition CITE AT LEAST 4
--then we get the answer
\qecho ' if we consider the condition cite atleast 4'

WITH CitedFewerThan2 as ( Select array(select distinct bcb.bno
									   from bookcitedbybooks bcb
									   where cardinality(bcb.citingBooks) < 2 ) as arr2),
			 CiteMoreThan4 as (select array (select distinct bb.bno
									from bookcitesbooks bb
									where cardinality (bb.citedBooks) >= 4) as arr4 )


select books.* 
from set_intersection((select arr2 from CitedFewerThan2), (select arr4 from CiteMoreThan4))books;


\qecho 'Problem 11'

-- Find the sid and name of each student who has all the majors of the
-- combined set of all majors of the oldest students who bought the book
-- with bno 2000.


								 
								 
with oldestStudent as (select (array(select s.sid
           from   Student s
           where  s.birthYear <= all (select s1.birthYear
                                 from   Student s1))) as oldStud),
								 
book2000 as (select (array(select unnest(bs.students)
                         from   bookBoughtByStudents bs
                         where  bs.bno = 2000)) as sbb),
old2000 as (select ( array ( select unnest(p.*)
		from set_intersection((select oldStud from oldestStudent),(select sbb from book2000))p)) as o2),
oldMajor as (select (array( select distinct unnest(shm1.majors)
						   from studentHasMajors shm1
						   where is_in(shm1.sid,(select o2 from old2000)))) as om)

select sid, sname
from   Student s
where  s.sid in (select shm.sid
                 from   studentHasMajors shm, oldMajor oldm
                 where  subset(oldm.om, shm.majors));


\qecho 'If  taken bno 2001 instead of 2000'					 
--If we take bno 2001 instead of 2000, we get the following answer

								 
with oldestStudent as (select (array(select s.sid
           from   Student s
           where  s.birthYear <= all (select s1.birthYear
                                 from   Student s1))) as oldStud),
								 
book2000 as (select (array(select unnest(bs.students)
                         from   bookBoughtByStudents bs
                         where  bs.bno = 2001)) as sbb),
old2000 as (select ( array ( select unnest(p.*)
		from set_intersection((select oldStud from oldestStudent),(select sbb from book2000))p)) as o2),
oldMajor as (select (array( select distinct unnest(shm1.majors)
						   from studentHasMajors shm1
						   where is_in(shm1.sid,(select o2 from old2000)))) as om)

select sid, sname
from   Student s
where  s.sid in (select shm.sid
                 from   studentHasMajors shm, oldMajor oldm
                 where  subset(oldm.om, shm.majors));



\qecho 'Problem 12'

-- Find the following set of sets
--  {M |M ⊆Major∧|M|≤3}.


with threes as (select set_union(set_union(make_singleton(m3.major),make_singleton(m4.major)),make_singleton(m5.major))
				from major m3, major m4, major m5)

select '{}' as "majors"
union
select th.* 
from threes th;  



\qecho 'The number of elements in the result is'

-- Reconsider Problem 12.
-- Let M denote the set {M | M ⊆ Major ∧ |M| ≤ 3}. Find the following set of sets
-- {X |X ⊆M∧|X|<= 2}.

create type majorArray as(major text);
create type majorsArray as (majors majorArray[]);

\qecho 'Problem 13'

with threes as (select  distinct set_union(set_union(make_singleton(row(m0.major)::majorArray),make_singleton(row(m1.major)::majorArray)),make_singleton(row(m2.major)::majorArray))
from   major m0, major m1, major m2),
Maj as (select '{}' as majors
union
(select th.* 
from threes th))

select count(p.*) as "count"
from (
    select '{}'
    union
    select set_union(make_singleton(row(my.majors)::majorsArray),make_singleton(row(mz.majors)::majorsArray))
from Maj my, Maj mz)p;


\qecho 'Problem 14'

-- Let t be a number called a threshold. We say that an (unordered)
-- triple of different sids {s1, s2, s3} co-occur with frequency at least
-- t if there are at least t books who are each bought by the students
-- s1, s2, and s3.  Write a function coOccur(t integer) that returns the
-- (unordered) triples {s1, s2, s3} of bno that co-occur with frequency
-- at least t.  Test your coOccur function for t in the range [0, 3].

CREATE OR REPLACE FUNCTION cooccur(t integer) 
RETURNS TABLE (threes text[]) AS 
$$
SELECT DISTINCT set_union(set_union(make_singleton(p.sid1),make_singleton(p.sid2)),make_singleton(p.sid3))
FROM (SELECT sbb1.sid AS sid1, sbb2.sid AS sid2, sbb3.sid AS sid3 
 	FROM studentbuysbooks sbb1,studentbuysbooks sbb2,studentbuysbooks sbb3
WHERE sbb1.sid <> sbb2.sid and sbb2.sid <> sbb3.sid and sbb1.sid <> sbb3.sid 
and cardinality(set_intersection(sbb3.books,(set_intersection(sbb1.books,sbb2.books)))) >= t)p

$$ LANGUAGE SQL;


-- t = 0
\qecho 'The number of triples is: '
SELECT count(*) AS "count"
FROM cooccur(0);

-- t = 1
\qecho 'The number of triples is: '
SELECT count(*) AS "count"
FROM cooccur(1);

-- t = 2
\qecho 'The number of triples is: '
SELECT count(*) AS "count"
FROM cooccur(2);

-- t = 3
\qecho 'The number of triples is: '
SELECT count(*) AS "count"
FROM cooccur(3);




-- Data for problem 15 through 18
DROP TABLE STUDENT cascade;
CREATE TABLE student (sid TEXT, sname TEXT, major TEXT, byear INT);
INSERT INTO student VALUES
('s100', 'Eric'  , 'CS'     , 1988),
('s101', 'Nick'  , 'Math'   , 1991),
('s102', 'Chris' , 'Biology', 1977),
('s103', 'Dinska', 'CS'     , 1978),
('s104', 'Zanna' , 'Math'   , 2001),
('s105', 'Vince' , 'CS'     , 2001);

CREATE TABLE course (cno TEXT, cname TEXT, dept TEXT);
INSERT INTO course VALUES
('c200', 'PL'      , 'CS'),
('c201', 'Calculus', 'Math'),
('c202', 'Dbs'     , 'CS'),
('c301', 'AI'      , 'CS'),
('c302', 'Logic'   , 'Philosophy');

CREATE TABLE enroll (sid TEXT, cno TEXT, grade TEXT);
insert into enroll values 
     ('s100','c200', 'A'),
     ('s100','c201', 'B'),
     ('s100','c202', 'A'),
     ('s101','c200', 'B'),
     ('s101','c201', 'A'),
     ('s102','c200', 'B'),
     ('s103','c201', 'A'),
     ('s101','c202', 'A'),
     ('s101','c301', 'C'),
     ('s101','c302', 'A'),
     ('s102','c202', 'A'),
     ('s102','c301', 'B'),
     ('s102','c302', 'A'),
     ('s104','c201', 'D');



\qecho 'Problem 15'
--Ref Prof notes and TA suggestions


-- Write a PostgreSQL view courseGrades that creates the nested rela-
-- tion of type (cno, gradeInfo{(grade, students{(sid)})})
-- This view should compute for each course, the grade information of the
-- students enrolled in this course. In particular, for each course and for
-- each grade, this relation stores in a set the sids students who obtained
-- that grade in that course.
-- Test your view.

create type studenttype as (sid text);
create type gradeStudentsType as (grade text,students studentType[]);

create or replace view courseGrades as
with E as
(select b.cno,b.grade ,array(select DISTINCT row( sid)::studenttype from enroll where grade=b.grade and cno=b.cno) as students
from enroll b
group by(b.cno,b.grade)
order by 1),
F as (select cno,array_agg(row(grade,students)::gradeStudentsType)as gradeInfo from e group by (cno))
select F.cno,F.gradeinfo from F;

select * from courseGrades;


\qecho 'Problem 16'

\qecho 'Problem 16.a'

-- (a) Find each pair (c, S) where c is the cno of a course and S is the 
-- set of sids of students who received an ‘A’ but not a ‘B’ in course c. 
-- The type of your answer relation should be (cno : text, Students : {(sid : text)}).

select cg.cno,g.students
from coursegrades cg,unnest(cg.gradeInfo)g
where g.grade='A' and g.grade!='C';

\qecho 'Problem 16.b'

--(b) Find each (s,C) pair where s is the sid of a students
-- and C is the set of cnos of courses in which the student received
-- an ‘A’ or a ‘B’ but not a ‘C’. The type of your answer relation should 
-- be (sid : text, Courses : {(cno : text)}).

Create type courseType as (cno text);

select y.sid,array_agg(row(cg.cno)::courseType) as courses
from coursegrades cg,unnest(cg.gradeInfo)g,unnest(g.students)y
where g.grade='A' or g.grade='B' and g.grade!='C'
group by y.sid
order by 1;

\qecho 'Problem 17'

-- WriteaPostgreSQLviewjcourseGradesthatcreatesasemi-structured database 
-- which stores jsonb objects whose structure conforms with the structure 
-- of tuples as described for the courseGrades in Problem 15.

-- Test your view.


create or replace view jcourseGrades AS
WITH E AS (SELECT cno, grade, jsonb_agg(jsonb_build_object('sid',sid)) as students
            FROM Enroll e
            GROUP BY (cno, grade)
          ),
F AS (SELECT jsonb_build_object('courses',cno, 'gradeInfo',
            jsonb_agg(jsonb_build_object('grade',grade,'students',students))) as courseInfo
            FROM E
            GROUP BY (cno)
            
            )
select * 
from F order by 1;

select * from jcourseGrades;


\qecho 'Problem 18'

\qecho 'Problem 18.a'
-- (a) Find each pair (c, s) where c is the cno of a course and s is the
-- sid of a student who received an ‘A’ in course c. The type of your
-- answer relation should be (cno:text, sid:text).


select courseInfo ->>'courses' as cno, s ->> 'sid' as sid
from jcourseGrades,
jsonb_array_elements(courseInfo ->'gradeInfo') g,
jsonb_array_elements(g -> 'students') s
where g -> 'grade' = '"A"';



\qecho 'Problem 18.b'
-- (b) Find each pair ({c1, c2}, S) where c1 and c2 are the course num-
-- bers of two different courses and S is the set of sids of students
-- who received a ’A’ in both courses c1 and c2. The type of your
-- answer relation should be (coursePair : {(cno : text)}, Students :
-- {(sid : text))}

with courseStudentInfo as (select courseInfo ->>'courses' as cno, s ->> 'sid' as sid, g-> 'grade' as grade
                            from jcourseGrades,
                            jsonb_array_elements(courseInfo ->'gradeInfo') g,
                            jsonb_array_elements(g -> 'students') s
),
distinct_courses AS ( select distinct csi1.cno as cno1, csi2.cno as cno2
                      from courseStudentInfo csi1, courseStudentInfo csi2
                      where csi1.cno != csi2.cno and csi1.cno < csi2.cno
                      order by 1,2)

select array[cno1,cno2] as "coursepair" , ARRAY(select unnest(sid)) as "students"
from ( select ROW(dc.cno1) as cno1, ROW(dc.cno2) as cno2,
  (select array_agg(row(csi3.sid))
    from courseStudentInfo csi3, courseStudentInfo csi4
    where csi3.cno = dc.cno1 and csi4.cno = dc.cno2 and csi3.sid = csi4.sid and csi3.grade = '"A"' and csi4.grade = '"A"') as sid
from distinct_courses dc)b;






-- Connect to default database
\c postgres

-- Drop database created for this assignment

DROP DATABASE dvgfall2022assignment5_1;




