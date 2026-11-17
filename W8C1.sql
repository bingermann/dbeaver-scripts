-- indexes can be made on any number of fields in the table

-- can build multiple indexes for the same table
-- (more indexes can be detrimentl, as more routes are added)0

-- The field the inde is built on is called the SEARCH KEY

-- Syntax:
create index on books(title);

create index on books(id, title);

create unique index on books(title);

create index on books((pagecount/10)*10);

create index on (date_trunc(timastamp, 'month');


-- Postgres automatically build an index on the PRIMARY KEY

----------ACTIVITY----------
-- Create an index on books.pagecount
create index on books(pagecount);

--Write a query that could take advantage of that index
select title, pagecount 
from books 
where pagecount > 250;
----------------------------

-- How do you know when a DB uses an index
explain select title, pagecount
from books
where pagecount = 500;
-- This does not use the index, likely to the table being so small

-- Try to use the index
create index on agent(agent_id);

explain select agent_id, first, last
from agent 
where agent_id = 55;

-- Explain shows 'Indedx Cond: (agent_id = 55)'

-- Index wouldnt be helpful with an OR in the predicate (after the where)
-- Would be helpful with an AND in the predicate
-- Ex \/
-- Index on ID
--- id = 5 is helpful
--- id = 5 AND title = 'The Joy Luck Club', still helpful because we 
----narrow down to the rows where ID is 5
--- title = 'The Joy Luck Club' OR id = 5, doesnt save anything because 
----we still have to search both rows entirely. The indx cannot help to find the title in the title row

----------ACTIVITY----------
-- For the below - indicate if the index matches the predicate or not
-- Assume index on books (id)
-- 1. id = 5132         
--- Yes, index is on id

-- 2. title = 'It' AND id = 5132
--- Yes, search gets narrowed down, only title rows with id = 5132 are shows

-- 3. title = 'It' OR id = 5132
--- No, both rows still need to be searched


-- Assume index on books (genre, pagecount)
-- 1. genre = 'Horror' AND pagecount > 2000
--- Yes, both rows are narrowed in th index

-- 2. genre = 'Horror'
--- Yes, index narrows the genre

-- 3. pagecount > 2000
--- No, order matters, pagecount is second, so order rules don't work here.
--- indexes work by sorting the fields in order. This one filters first thrrough genre, THEN through pagecount.
----------------------------


