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
