-- Subquery in the select clause
select b.title, b.pagecount, (select max(pagecount) from books) as max
from books b;


-- Subquery in the from
select b.genre
from (select * from books where pagecount > 250) as b;

-- ANY WORK WITH NULL --> NULL
select 7 = null;
select 7 <> null;
select null + 5;
select 12 - null;

-- View can be updated if:
-- Single defined base table
-- Only select and project
-- No aggregates
-- No distinct

-- Create a view to list only horror books
create or replace view HorrorBooks as
select * 
from books
where genre = 'Horror';

select * from HorrorBooks;

-- Create a vew that lists books published by Viking
create or replace view VikingBooks as
select *
from books b
where b.pubid in (
				select p.id
				from publishers p
				where p.name = 'Viking');
select * from VikingBooks;

select * from books;
select * from publishers;

-- Create a view that contains the names of publishers and
-- the number of books published by them.
create or replace view pubPublishes as
select p.name, count (*)
from publishers p
join books b on p.id = b.pubid
group by p.name;
select * from pubPublishes;

