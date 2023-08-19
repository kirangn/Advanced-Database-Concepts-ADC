-- Script for B561 Fall 2022 Assignment 7

create database dvgassignment7;

\c dvgassignment7


\qecho 'Problem 8'

--- Topological sort
create table V(node int);
create table E(source int, target int);


insert into V values
   (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12);

insert into E values
   (1,2),
   (1,3),
   (1,4),
   (2,5),
   (2,6),
   (3,7),
   (4,8),
   (5,9),
   (7,10),
   (7,11),
   (9,12);

-- 8a
create table E1 (source int, target int);
create or replace function topo_sort() returns int[] as $$
declare vert int; arr_ int[] := '{}';
begin
    drop table if exists E1;
    create table E1 (source int, target int);
    insert into E1 select * from E;
    case when (select node in (select unnest(arr_)) from V limit 1)
    then
  loop
      vert := (select e.source 
         from   E1 e
         where  e.source <> e.target
         limit 1);
      arr_ := array_append(arr_, vert);
      delete from E1 where source = vert;   
    end loop;
  else
    return array_cat(arr_, (select array(select node from   V )));
  end case;
end;
$$ language plpgsql;

select * from topo_sort();

-- 8b


create or replace function perms(elements int[]) 
returns   table (permutation int[]) as
$$
   select '{}'
   where  elements = '{}'
   union
   select array_append(permutation,element)
   from   unnest(elements) element, 
          lateral(select permutation 
                  from   perms(array_remove(elements,element))) P
$$ language sql;

select count(*) from perms('{1,2,3,4,5,6,7,8}');
--select count(*) from perms('{1,2,3,4,5,6,7,8,9,10,11,12}')



\qecho 'Problem 9'
-- Dijkstra Algorithm

create table Graph(source int,
                   target int,
                   weight int);

insert into Graph values
  (0,1,2),
  (1,0,2),
  (0,4,10),
  (4,0,10),
  (1,3,3),
  (3,1,3),
  (1,4,7),
  (4,1,7),
  (2,3,4),
  (3,2,4),
  (3,4,5),
  (4,3,5),
  (4,2,6),
  (2,4,6);


create table sp_store(s int,t int,dist int);
create or replace function TC_pairs() returns table (s integer,t integer,wt integer) as
$$ 
(select sp_store.s,Graph.target,(Graph.weight+sp_store.dist) as wt
from sp_store join Graph on (sp_store.t=Graph.source))
except
(select sp_store.s,Graph.target,sp_store.dist
from sp_store join Graph on (sp_store.s=Graph.target));
$$ language sql;


create or replace function Dijkstras(s int) returns table(t int,dist int) as $$
declare x record; y int:= (select count(source) from Graph);
begin
drop table if exists sp_store;
create table sp_store(s int,t int,dist int);
insert into sp_store(select g.*
           from Graph g 
           where g.source=s);

while  (y > 0)
loop 
y= y - 1;
for x in (select * from TC_pairs())
loop
case when x.s = x.t THEN
insert into sp_store values(x.s,x.t, 0);
else
insert into sp_store values(x.s,x.t,x.wt);
end case;
end loop;
end loop;
return query (select sp_store.t,min(sp_store.dist) 
       from sp_store 
       group by sp_store.t
       order by 1);
end;
$$ language plpgsql;


SELECT n.source, d.t, d.dist
FROM   (select distinct source from Graph) n, lateral (select t, dist from Dijkstras(n.source)) d;

\qecho 'Problem 10'

create table partSubpart(pid int, sid int, quantity int);
create table basicPart(pid int, weight int);

insert into partSubpart values 
   (1,2,1),
   (1,3,3),
   (1,4,2),
   (2,5,1),
   (2,6,4),
   (3,7,2),
   (4,8,1),
   (5,9,2),
   (7,10,2),
   (7,11,3),
   (9,12,5);

insert into basicPart values
  (6,  1),
  (8,  4),
  (10, 1),
  (11, 5),
  (12, 3);

\qecho 'Problem 10.a'

-- Write a {\bf recursive} function {\tt recursiveAggregatedWeight(p
-- integer)} that returns the aggregated weight of a part {\tt p}.
create or replace function recursiveAggregatedWeight(p int) returns bigint as $$
declare w int:= 0; wx int:=0; x record;
begin
case when (select p not in(select bp.pid from basicPart bp))
then for x in (select ps.sid
           from partsubpart ps
           where ps.pid=p)
loop
   case when (select x.sid in (select bp.pid from basicPart bp ))
   then 
   wx:=(select ps.quantity * bp.weight 
      from partsubpart ps join basicPart bp on (ps.sid=x.sid and bp.pid=x.sid));  
   else
   wx:= (select  ps.quantity
      from partsubpart ps
      where ps.sid = x.sid) * recursiveAggregatedWeight(x.sid);   
  end case;
w:= w + wx;
end loop;
else 
w:=(select bp.weight 
  from basicPart bp
  where bp.pid=p);
end case; 
return w;
end;
$$ language plpgsql;


select distinct q.pid, recursiveAggregatedWeight(q.pid)
from  (select ps.pid from partSubPart ps union select bp.pid from basicPart bp) q order by 1;

\qecho 'Problem 10.b'

-- Write a {\bf non-recursive} function {\tt
-- nonRecursiveAggregatedWeight(p integer)} that returns the aggregated
-- weight of a part {\tt p}.  Test your function.
create table store( prod_id int, quant int );

create or replace function quants( ) returns table(prod_id int, quant int ) as $$
   select ps.pid, st.quant*ps.quantity
   from partSubPart ps, store st
   where ps.sid = st.prod_id
   except
   select st.prod_id, st.quant
   from store st
$$ language sql;

CREATE OR REPLACE FUNCTION nonrecursiveaggregatedweight(p int) returns bigint as $$
declare w int:= 0; 
BEGIN
case when ( select p in (select bp.pid
             from basicPart bp) )
then w:= (select bp.weight
      from basicPart bp
      where bp.pid=p);
return w;      
else
insert into store select bp.* 
          from basicPart bp;
while exists (select prod_id from quants())
then
loop
  insert into store (select * from quants());
end loop;
end case;
w:= (SELECT sum(st.quant) 
    FROM store st
    WHERE st.prod_id = p );
return w;
end;
$$ language plpgsql;


select distinct q.pid, nonrecursiveaggregatedweight(q.pid)
from  (select ps.pid from partSubPart ps union select bp.pid from basicPart bp) q order by 1;


\qecho 'Problem 11'

-- Write a PostgreSQL program frequentSets(t int) that returns the sets
-- of all t-frequent sets.

create table personSkills(doc int, words text[]);

insert into personSkills values
  (1, '{"A", "B", "C", "D", "E"}'),
  (2, '{"A", "B", "C", "E", "F"}'),
  (3, '{"A", "E", "F"}'),
  (4, '{"E", "A"}');


  create or replace function set_outputs(arr_ anyarray) returns table(p_set text[]) as
$$
DECLARE x text; y record;
BEGIN
drop table if exists set_outputs;
create table set_outputs(p_set text[]);
insert into set_outputs values('{}');
 foreach x in array arr_ loop
	for y in (select * from set_outputs) loop
	insert into set_outputs values(array_append(y.p_set,x));
	end loop;
	end loop;
return query(select arr_ 
			 from set_outputs);
end;
$$ language plpgsql;

DROP TABLE IF EXISTS freq_sets;
CREATE TABLE freq_sets(set_combs text[]);
create or replace function frequentsets(t int) returns table(frequentsets text[]) AS
$$ BEGIN

INSERT INTO freq_sets (SELECT set_outputs(ps.words) 
						from personskills ps );
return query (select set_combs
			  from freq_sets );
 END;
$$ language plpgsql;
					   
select frequentsets(0);





\qecho 'Problem 12' 
-- Hamiltonian

\qecho 'Problem 12.a'

-- Write a {\bf recursive} function {\tt recursiveHamiltonian()} that
-- returns {\tt true} if the graph stored in {\tt Graph} is
-- Hamiltonian, and {\tt false} otherwise.

drop table Graph;
create table Graph(source int, target int);

--below functions are taken from professor's slides/code
-- recursive function to generate permutations 
/* Recursive Function to compute all permutations of a set of elements */
create or replace function recursive_permutations(elements int[]) 
returns   table (permutation int[]) as
$$
   select '{}'
   where  elements = '{}'
   union
   select array_append(permutation,element)
   from   unnest(elements) element, 
          lateral(select permutation 
                  from   recursive_permutations(array_remove(elements,element))) P
$$ language sql;

--  The function 'count_Nodes' computes the number of nodes in Graph
create or replace function count_Nodes()
returns int as
$$
select count(1)::int
from   (select source from graph
        union
        select target from graph) q;
$$ language sql;

-- The function 'is_Hamiltonian_Path' check if 'path'is an Hamiltonian path in Graph

create or replace function is_Hamiltonian_Path(path    int[]) 
returns   boolean as
$$
select 
      (select count(1)
       from  (select i
              from   generate_series(1,cardinality(path)-1) i
              where  (path[i],path[i+1]) in (select e.source, e.target
                                             from   Graph e)
              union 
              select cardinality(path)
              where  (path[cardinality(path)],path[1]) in (select e.source, e.target
                                                           from   Graph e)) q) = cardinality(path);
$$ language sql;

-- The function 'Hamiltonian' determines if Graph is a Hamiltonian graph

create or replace function  recursiveHamiltonian()
returns boolean as
$$
select   exists(select 1
                from   recursive_permutations((select array(select i from generate_series(1,count_Nodes()) i)))
                where  is_Hamiltonian_Path(permutation::int[]));
$$ language sql;


-- Test your function on the following graphs.

-- delete from Graph;
-- insert into Graph values (1,2), (2,3), (3,1);

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,1);

--this should return True
select recursiveHamiltonian();

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,1),
 (4,5),
 (5,4);

--this should return false
select recursiveHamiltonian();

\qecho 'Problem 12.b'

-- Write a {\bf non-recursive} function {\tt nonRecursiveHamiltonian}
-- that returns {\tt true} if the graph stored in {\tt Graph} is
-- Hamiltonian, and {\tt false} otherwise. 


/* Iterative function to compute all permutations of a set of elements */

create or replace function iterative_permutations(elements int[])
returns table ("permutation" int[]) as
$$
declare 
   i int;
   ct_elements int := cardinality(elements);
begin
  drop table if exists element;
  create table element(element int);
  drop table if exists permutation;
  create table permutation (permutation int[]);

  insert into element (select unnest(elements));
  insert into permutation values ('{}');

  for i in 1..ct_elements loop
     insert into permutation
          select array_append(p.permutation,element)
          from   permutation p, element
          where  element not in (select unnest(p.permutation)) and
                 cardinality(p.permutation) = i-1;                                       
  end loop;
  return query select p.permutation
               from   permutation p
               where  cardinality(p.permutation) = ct_elements;
end;
$$ language plpgsql;

create or replace function   nonRecursiveHamiltonian()
returns boolean as
$$
select   exists(select 1
                from   iterative_permutations((select array(select i from generate_series(1,count_Nodes()) i)))
                where  is_Hamiltonian_Path(permutation::int[]));
$$ language sql;



delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,1);

--this should return True
select nonRecursiveHamiltonian();

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,1),
 (4,5),
 (5,4);

--this should return False
select nonRecursiveHamiltonian();

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,5),
 (5,6),
 (6,7),
 (7,8),
 (8,9),
 (9,10),
 (10,1);

--this should return True
select nonRecursiveHamiltonian();

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,5),
 (5,6),
 (6,7),
 (7,8),
 (8,9),
 (9,10);

--this should return False
select nonRecursiveHamiltonian();


\qecho 'Problem 13'

--  The function 'count_Nodes' computes the number of nodes in Graph
create or replace function count_Nodes()
returns int as
$$
select count(1)::int
from   (select source from graph
        union
        select target from graph) q;
$$ language sql;

create or replace function isSafeToColor(color INT[])
  returns boolean as
  $$
  declare 
   i int;
   nodes int := count_Nodes();
  begin
  for i in 1..nodes loop
    for j in i+1..nodes loop
      IF ((i,j) in (select e.source, e.target
                     from   Graph e) ) and color[j] = color[i]
      THEN
      return False;
      END IF;
    END LOOP;
  END LOOP;
  RETURN TRUE;
  END;
  $$ language plpgsql;

create or replace function graphColoring(i int ,color int[])
  returns boolean as
  $$
  declare 
   total_colors int := 3;
   nodes int := count_Nodes();
  BEGIN
  IF i=nodes THEN
    IF isSafeToColor(color::int[]) THEN
      RETURN TRUE;
    END IF;
    RETURN FALSE;
  END IF;

  FOR j in 1..total_colors loop
    color[i] = j;
    IF graphColoring(i+1, color::int[]) THEN
      RETURN TRUE;
    END IF;
    color[i] = 0;
  END LOOP;
  return false;
  END;
  $$ language plpgsql;

create or replace function threeColorable()
returns boolean as
$$
declare color int[] := ARRAY[]::integer[];
begin
return graphColoring(1,color::int[]);
end;
$$ language plpgsql;


delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,5),
 (5,1);
select threeColorable();


delete from Graph;
insert into Graph values
 (1,2),
 (2,1),
 (1,3),
 (3,1),
 (1,4),
 (4,1),
 (2,3),
 (3,2),
 (2,4),
 (4,2),
 (3,4),
 (4,3);

select threeColorable();


\qecho 'Problem 14'

create table dataSet(p integer, x float, y float);

insert into dataSet values
 (1, 1, 1),
 (2, 1, 2),
 (3, 1, 3),
 (4, 1, 4),
 (5, 1, 5),
 (6, 1, 6),
 (7, 1, 7),
 (8, 1, 8),
 (9, 1, 9),
 (10, 1, 10),
 (11, 2, 1),
 (12, 2, 2),
 (13, 2, 3),
 (14, 2, 4),
 (15, 2, 5),
 (16, 2, 6),
 (17, 2, 7),
 (18, 2, 8),
 (19, 2, 9),
 (20, 2, 10),
 (21, 3, 1),
 (22, 3, 3),
 (23, 3, 4),
 (24, 3, 5),
 (25, 3, 6),
 (26, 3, 7),
 (27, 3, 8),
 (28, 3, 9),
 (29, 4, 1),
 (30, 4, 2),
 (31, 4, 4),
 (32, 4, 5),
 (33, 4, 6),
 (34, 4, 7),
 (35, 4, 8),
 (36, 4, 9),
 (37, 4, 10),
 (38, 5, 2),
 (39, 5, 4),
 (40, 5, 5),
 (41, 5, 6),
 (42, 5, 8),
 (43, 5, 9),
 (44, 5, 10),
 (45, 6, 2),
 (46, 6, 3),
 (47, 6, 4),
 (48, 6, 5),
 (49, 6, 6),
 (50, 6, 7),
 (51, 6, 8),
 (52, 6, 9),
 (53, 6, 10),
 (54, 7, 2),
 (55, 7, 3),
 (56, 7, 5),
 (57, 7, 6),
 (58, 7, 7),
 (59, 7, 8),
 (60, 7, 9),
 (61, 7, 10),
 (62, 8, 2),
 (63, 8, 3),
 (64, 8, 4),
 (65, 8, 5),
 (66, 8, 6),
 (67, 8, 7),
 (68, 8, 8),
 (69, 8, 9),
 (70, 9, 2),
 (71, 9, 3),
 (72, 9, 4),
 (73, 9, 5),
 (74, 9, 7),
 (75, 9, 8),
 (76, 9, 9),
 (77, 9, 10),
 (78, 10, 2),
 (79, 10, 3),
 (80, 10, 4),
 (81, 10, 5),
 (82, 10, 6),
 (83, 10, 7),
 (84, 10, 8);


create or replace function shouldStop(iterations integer)
returns boolean as
$$
declare MAX_ITERATIONS int := 20;
begin
IF iterations > MAX_ITERATIONS OR (select true = all (select (oc.x,oc.y) in (select x,y from centroid)
                                  from old_centroids oc)) THEN
  RETURN TRUE;
ELSE
  RETURN FALSE;
END IF;
end;
$$ language plpgsql;

create or replace function getCentroids()
returns void as
$$
declare i record;
x1 int;
y1 int;
begin
--calculate mean of all x and all y of points assigned to the centroid
for i in (select * from centroid) loop
  x1 := (select avg(x) from new_dataset d where d.label = i.cid);
  y1 := (select avg(y) from new_dataset d where d.label = i.cid);
  UPDATE centroid
  set x = x1,
  y = y1
  where cid = i.cid;
end loop;
end;
$$ language plpgsql;

create or replace function getLabels()
returns void as
$$
declare distance int := 10000000;
temp_distance int;
i record;
j record;
--least distance from centroid will be the new label
begin
drop table if exists new_dataset;
create table new_dataset(cid integer, x float, y float, label integer);
--choose closest centroid and make that the label
delete from new_dataset;
for i in (select * from dataset) loop
  distance := 10000;
  INSERT INTO new_dataset values (i.p,i.x,i.y,0);
  for j in (select * from centroid) loop
    temp_distance := sqrt(power(i.x-j.x,2) + power(i.y - j.y,2));
    IF temp_distance <= distance THEN
      raise notice 'distance %',temp_distance;
      distance := temp_distance;
      update new_dataset
        set label = j.cid
        where cid = i.p;
    end if;
  end loop;
end loop;
end;
$$ language plpgsql;

CREATE OR REPLACE FUNCTION choose_one_from_A() RETURNS text AS
$$
   DECLARE element_from_A text; 
   BEGIN
     SELECT INTO element_from_A a.p
     FROM (SELECT p from dataset ORDER BY random()) a; 
     RETURN element_from_A;
   END;
$$ language plpgsql;

select choose_one_from_A();

create or replace function kMeans(k integer)
returns table (cid integer, x float, y float) AS
$$
declare 
numFeatures int := 2;
iterations int := 0;
selected_label int;
condition boolean;
begin
drop table if exists centroid;
create table centroid(cid integer, x float, y float);
drop table if exists old_centroids;
create table old_centroids(cid integer, x float, y float);

--choose k centroids randomly from the dataset and assign 
while ((select count(*) from centroid) < k) loop
selected_label := choose_one_from_A();
IF selected_label not in (select c.cid from centroid c) THEN
  INSERT INTO centroid select d.p,d.x,d.y from dataset d where d.p=selected_label;
END IF;
end loop;
condition := shouldStop(iterations);
raise notice 'condition', condition;
while not condition
loop
  delete from old_centroids;
  insert into old_centroids select * from centroid;
  iterations := iterations + 1;
  select getLabels();
  select getCentroids();
end loop;
return query (select * from centroid);
end;
$$ language plpgsql;

select * from kMeans(1);

select * from kMeans(2);

select * from kMeans(3);

select * from kMeans(4);






\c postgres
drop database dvgassignment7;

