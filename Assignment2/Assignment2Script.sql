-- Script for Assignment 2 Collaborated with Aditi Soni,Yash Shah

-- Creating database with full name

CREATE DATABASE dvgfall2022assignment21;


-- Connecting to database 
\c dvgfall2022assignment2

-- Relation schemas and instances for assignment 2


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

create table PC(parent integer,
                child integer);

insert into PC values
 (1,2),
 (1,3),
 (1,4),
 (2,5),
 (2,6),
 (3,7),
 (5,8),
 (8,9),
 (8,10),
 (8,11),
 (7,12),
 (7,13),
 (12,14),
 (14,15);

\qecho 'Problem 3'

-- Find the bno and title of each book that is bought by a student who
-- is (strictly) younger than each student who majors in Chemistry and
-- who also bought that book.


\qecho 'Problem 3.c'

-- Express this query in Pure SQL by only using the ‘true = some’ or
-- ‘true = all’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.

select b.bno, b.title 
from book b where true=some(select b.bno=t.bno
						   from buys t 
						   where true=some(select t.sid=s.sid from student s
										  where true=all (select s.birthyear>s1.birthyear
														 from student s1,hasmajor hm
														 where hm.sid=s1.sid and
														  hm.major='Chemistry' and t.sid=s1.sid )));
														
		    
\qecho 'Problem 3.d'

-- Express this query in Pure SQL by only using the ‘exists’ or ‘not
-- exists’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.

select b.bno, b.title 
from book b where exists (select 1
						   from buys t 
						   where b.bno=t.bno and
						  exists(select 1 from student s
								where t.sid=s.sid and s.birthyear > all(select s1.birthyear 
																		from student s1 , hasmajor hm 
																		where hm.sid = s1.sid and hm.major='Chemistry'and t.sid=s1.sid )));
										 
														

\qecho 'Problem 3.e'

-- Express this query in Pure SQL by only using the `in' or `not in' subquery
-- expressions. You can not use the set operations INTERSECT, UNION, and
-- EXCEPT.


select b.bno ,b.title
from book b where b.bno in (select t.bno
						   from Buys t 
						   where t.sid in (select s.sid from student s
										  where s.birthyear > all(select s1.birthyear
														  from student s1 , hasmajor hm
														  where hm.sid = s1.sid and hm.major='Chemistry')));
														  
														

\qecho 'Problem 3.f'

-- Express this query in Pure SQL without using subquery expressions. Now
-- you can use the set operations INTERSECT, UNION, and EXCEPT.

select b.bno,b.title
 from book b, buys t 
 where b.bno=t.bno
 intersect
 select b.bno,b.title
 from book b, student s, buys t
 where t.bno=b.bno and t.sid=s.sid and 
 s.birthyear > all(select s1.birthyear
						 from student s1 , hasmajor hm
						 where hm.sid = s1.sid and hm.major='Chemistry');

\qecho 'Problem 4'

-- Find each student-book pair (s, b) where s is the sid of a student who
-- majors in CS and who bought each book that costs no more than
-- book b.

\qecho 'Problem 4.b'

-- Express this query in Pure SQL by only using the ‘true = some’ or
-- ‘true = all’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.

select t.sid, t.bno
 from buys t, hasMajor hm
 where hm.sid = t.sid
 and hm.major = 'CS'
 and true = all(select true=some (select t1.sid = t.sid
								 from buys t1
								 where t1.bno = b.bno)
			   from book b
			   where b.price <=(select b1.price
							  from book b1
							  where b1.bno = t.bno));
							  
				
\qecho 'Problem 4.c'

-- Express this query in Pure SQL by only using the ‘exists’ or ‘not
-- exists’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.

select t.sid, t.bno
 from buys t, hasMajor hm
 where hm.sid = t.sid
 and hm.major = 'CS'
 and not exists (select 1
			   from book b
			   where b.price <=(select b1.price
							  from book b1
							  where b1.bno = t.bno) and 
				 not exists (select 1
							from buys t1
								 where t1.bno = b.bno and t1.sid = t.sid));


\qecho 'Problem 4.d'

-- Express this query in Pure SQL by only using the `in' or `not in' subquery
-- expressions. You can not use the set operations INTERSECT, UNION, and
-- EXCEPT.

select t.sid, t.bno
 from buys t, hasMajor hm
 where hm.sid = t.sid
 and hm.major = 'CS'
 and t.bno not in (select b1.bno
			   from book b,  book b1
			   where  b.price <= b1.price  and 
				t.sid not in  (select t1.sid 
							from buys t1
								 where t1.bno = b.bno));
					


\qecho 'Problem 4.e'

-- Express this query in Pure SQL without using subquery expressions. Now
-- you can use the set operations INTERSECT, UNION, and EXCEPT.


select cs_sid.sid,cs_sid.bno
from (select b.sid ,b.bno,t.price
from buys b,book t
where true=some(select b.sid = hm.sid from hasmajor hm
			   where hm.major='CS' and b.bno=t.bno)) cs_sid
except
(select Fin.sid,Fin.bno
from(
(select cs_sid.sid,cs_sid.bno,b.bno as bookno from 
(select b.sid ,b.bno,t.price
from buys b,book t
where true=some(select b.sid = hm.sid from hasmajor hm
			   where hm.major='CS' and b.bno=t.bno)) cs_sid,book b where cs_sid.price >=b.price)
EXCEPT
(select cs_sid.sid,cs_sid.bno,b.bno as bookno  from (select b.sid ,b.bno,t.price
from buys b,book t
where true=some(select b.sid = hm.sid from hasmajor hm
			   where hm.major='CS' and b.bno=t.bno)) cs_sid,buys q,book b where cs_sid.price >=b.price and q.bno=b.bno and q.sid=cs_sid.sid)
) Fin);
			   

\qecho 'Problem 5'

-- Find the sid and name of each student who bought all-but-one book that
-- cost strictly more than $30.



\qecho 'Problem 5.b'

-- Express this query in Pure SQL by only using the ‘true = some’ or
-- ‘true = all’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.


select s.sid,s.sname
from student s
where true=all(select b_30_1.bno =b_30_2.bno
			  from (select * from book
			   where price >30) b_30_1,(select * from book
			   where price >30) b_30_2
			  where true=all(select b_30_1.bno <> t.bno
							from buys t,book b1
							where t.sid=s.sid 
							and b1.bno = t.bno) 
			  and true=all(select b_30_2.bno <> t2.bno
						  from buys t2,book b2
						  where t2.sid=s.sid
						  and b2.bno=t2.bno
						  ));
						  



\qecho 'Problem 5.c'

-- Express this query in Pure SQL by only using the ‘exists’ or ‘not
-- exists’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.


select s.sid,s.sname
from student s
where not exists (select 1
			  from (select * from book
			   where price >30) b_30_1,(select * from book
			   where price >30) b_30_2
			  where not exists (select 1
							from buys t,book b1
							where t.sid=s.sid 
							and b1.bno = t.bno and b_30_1.bno = t.bno )
			  and not exists (select 1 
						  from buys t2,book b2
						  where t2.sid=s.sid
						  and b2.bno=t2.bno and b_30_2.bno = t2.bno
						  )
			 and b_30_1.bno <> b_30_2.bno );




\qecho 'Problem 5.d'

-- Express this query in Pure SQL by only using the `in' or `not in' subquery
-- expressions. You can not use the set operations INTERSECT, UNION, and
-- EXCEPT.

select s.sid,s.sname
from student s
where  s.sid not in ( select s1.sid
			  from  
				   student s1 ,
				   (select * from book where price >30) b_30_1,
					(select * from book where price >30) b_30_2
			  where 
			 s1.sid = s.sid and
			  b_30_1.bno not in (select b1.bno
							from book b1, buys t 
							where b1.bno = t.bno and t.sid=s1.sid ) 
			  and b_30_2.bno not in  (select b2.bno 
						  from book b2 , buys t2
						  where b2.bno=t2.bno and t2.sid=s1.sid
						  )
			 and b_30_1.bno <> b_30_2.bno );

					 


\qecho 'Problem 5.e'

-- Express this query in Pure SQL without using subquery expressions. Now
-- you can use the set operations INTERSECT, UNION, and EXCEPT.
with Book_greater_than_30 as (select t.sid,b.bno
							 from Buys t,Book b
							 where b.price > 30
							 and t.bno = b.bno)
							 
select s.sid,s.sname
from (select distinct b30_1.sid from Book_greater_than_30 b30_1
	  except(select distinct b30_1.sid 
			 from Book_greater_than_30 b30_1
			 except 
			 select distinct b30_1.sid 
			 from Book_greater_than_30 b30_1, Book_greater_than_30 b
			 where b30_1.bno <> b.bno 
			 and b30_1.sid = b.sid))a,
Student s
where s.sid = a.sid;



\qecho 'Problem 10.b'

-- Find the bno and title of each book that was bought by exactly one
-- student.

-- Express this query in RA SQL.

select b.bno,b.title
from book b join buys t on b.bno=t.bno
EXCEPT
select b.bno, b.title
from book b join buys t on t.bno=b.bno join buys t1 on (t1.bno=b.bno and t1.sid <> t.sid);


\qecho 'Problem 11.b'

-- Find each pair (m, b) where m is a major and b is the bno of a book
-- bought by a student who has major m and such that the price of b is
-- the lowest among the set of books bought by students with major m

-- Express this query in RA SQL.

select distinct hm.major,  b.bno 
from book b join buys t on (t.bno = b.bno) join hasMajor hm on (hm.sid = t.sid)
except 
select distinct hm.major, b.bno 
from book b join buys t on (t.bno = b.bno) join hasMajor hm on (hm.sid = t.sid) join hasMajor hm2 on (hm.major = hm2.major)
             join buys t2 on (hm2.sid = t2.sid)
             join book b2 on (t2.bno = b2.bno and b.price > b2.price);


\qecho 'Problem 12.b'

-- Find the bno and title of each book that is bought by a student who is
-- (strictly) younger than each student who majors in Chemistry and who
-- also bought that book.

-- Express this query in RA SQL.

select distinct b.bno,b.title
 from (buys t join student s on t.sid=s.sid join book b on b.bno=t.bno)
 cross join student s1 join hasMajor hm on hm.sid=s1.sid and s.birthyear > s1.birthyear
 where hm.major='Chemistry';

\qecho 'Problem 13.b'

-- Find each student-book pair (s, b) where s is the sid of a student who
-- majors in CS and who bought each book that costs no more than
-- book b.


-- Express this query in RA SQL.
select bu.sid, bu.bno
from buys bu
join book b on (bu.bno = b.bno)
join hasMajor h on (bu.sid = h.sid and h.major = 'CS')
except(select b.sid,b.bno
	   from ((select bu.sid, bu.bno, b1.bno as bno1
			  from buys bu
			  join book b on (bu.bno = b.bno)
			  join hasMajor h on (h.major = 'CS' and bu.sid = h.sid)
			  join book b1 on (b.price >= b1.price))
			 except
			 (select a.sid,a.bno,b.bno as bno1
			  from (select bu.sid,bu.bno,b.price
					from buys bu
					join book b on (bu.bno = b.bno)
					join hasMajor h on (h.major = 'CS' and bu.sid = h.sid)) a 
			  join buys bu on (a.sid = bu.sid)
			  join book b on (a.price >= b.price and bu.bno = b.bno)))b);
			  


\qecho 'Problem 14.b'

-- Find the sid and name of each student who bought all-but-one book that
-- cost strictly more than $30.

with morethan30 as (select t.sid,b.bno from buys t join Book b on t.bno=b.bno where b.price >30)

select s.sid,s.sname from Student s  join (select distinct m.sid from morethan30 m 
									 EXCEPT
									 (select distinct m.sid from morethan30 m 
									 EXCEPT
									  select distinct m.sid from morethan30 m  join morethan30 t1 
									  on m.bno<>t1.bno and m.sid=t1.sid ))k on k.sid=s.sid;



\qecho 'Problem 27'

/*
 Define a parameterized view
 ‘PurchasedBookLessPrice(sid int, price integer)’
 that returns, for a given student identi- fied by ‘sid’ and
a given ‘price’ value, the subrelation of ‘Book’ of books that are
bought by that student and that cost strictly less than ‘price’.

Test your view for the parameter values (1001,15), (1001,20),
(1001,50), and (1002,30).

*/

 Drop function IF EXISTS PurchasedBookLessPrice(sid1 int,price1 int);
create function PurchasedBookLessPrice(sid1 int ,price1 int) returns Table(bno int,title text, price int) as
	$$ 
	select b.bno,b.title,b.price from 
	book b,buys t,student s
	where s.sid=t.sid and t.bno = b.bno and s.sid=sid1 and b.price<price1 ;
	$$ Language sql;
	
select c.bno,c.title,c.price from PurchasedBookLessPrice(1001,15) c;
select c.bno,c.title,c.price from PurchasedBookLessPrice(1001,30) c; 
select c.bno,c.title,c.price from PurchasedBookLessPrice(1001,50) c;
select c.bno,c.title,c.price from PurchasedBookLessPrice(1002,30) c;

\qecho 'Problem 28'

/*
Define a parameterized view ‘CitedBookbyMajor(major text)’ that
returns for a major ‘major’ the subrelation of ‘Book’ of books that
are cited by a book bought by a the student who majors in ‘major’.

Test your view for each major.
*/

DROP function IF EXISTS CitedBookByMajor(major1 text);
create function CitedBookByMajor(major1 text) returns Table(bno int,title text, price int) as
	$$ 
	select distinct b.bno,b.title,b.price from 
	book b,cites c
	where c.bno2 in (select t.bno from buys t, hasmajor hm
					where t.bno=b.bno and t.sid=hm.sid and hm.major=major1);
	$$ Language sql;
	
select c.bno,c.title,c.price from CitedBookByMajor('CS') c;
select c.bno,c.title,c.price from CitedBookByMajor('Chemistry') c;
select c.bno,c.title,c.price from CitedBookByMajor('DataScience') c;
select c.bno,c.title,c.price from CitedBookByMajor('English') c;
select c.bno,c.title,c.price from CitedBookByMajor('Math') c;
select c.bno,c.title,c.price from CitedBookByMajor('Physics') c;



\qecho 'Problem 29'

/*
Define a parameterized view
‘JointlyBoughtBook(sid1 integer, sid2 integer)’
that returns the subrelation of ‘Book’ of books that are
bought by both the students with sids ‘sid1’ and ‘sid2’, respectively.

Test your view for the parameters (1001, 1002), (1001,1003), and
(1002,1003).
*/


create function JointlyBoughtBook(sid1 int, sid2 int) returns Table(bno int,title text, price int) as
	$$ 
	select  b.bno,b.title,b.price from 
	book b,buys t
	where t.bno =b.bno and t.sid=sid1
	intersect
	select  b.bno,b.title,b.price from 
	book b,buys t
	where t.bno =b.bno and t.sid=sid2;
	$$ Language sql;
select c.bno,c.title,c.price from JointlyBoughtBook(1001,1002) c;
select c.bno,c.title,c.price from JointlyBoughtBook(1001,1003) c;
select c.bno,c.title,c.price from JointlyBoughtBook(1002,1003) c;


\qecho 'Problem 30'

/*
Let PC(parent : integer,child : integer) be a rooted parent- child
tree. So a pair (n, m) in ‘PC’ indicates that node n is a parent of
node m. The ‘sameGeneration(n1, n2)’ binary relation is inductively
defined using the following two rules:

(1) If n is a node in PC, then the pair (n, n) is in the
sameGeneration relation. (Base rule)

(2) If n1 is the parent of m1 in PC and n2 is the parent of m2 in PC
and (n1,n2) is a pair in the sameGeneration relation then (m1, m2) is
a pair in the sameGeneration relation. (Inductive Rule)

Write a recursive view for the sameGeneration relation. Test your
view.
*/
Drop view if exists sameGeneration;
  create recursive view sameGeneration (n1,n2)                                                                                                                                     
 as  ((select  pc1.parent as n1, pc1.parent as n2
       from    pc pc1
       union   
       select  pc1.child as n1, pc1.child as n2
       from    pc pc1)                                                                                                                                                             
       union                                                                                                                                                                   
       select  pc2.child, pc3.child
       from    pc pc2, sameGeneration s, pc pc3
       where   pc2.parent = s.n1 and pc3.parent = s.n2 );   

 
select * from sameGeneration;





-- Connect to default database
-- \c postgres

--
-- Drop database created for this assignment
-- DROP DATABASE dvgfall2022assignment2;




