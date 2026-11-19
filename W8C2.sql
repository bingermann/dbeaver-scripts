-- An index can only have one cluster of one field at a time.
-- If a new cluster is created with a different field, the original
-- cluster will be replaced

select * from books;
create index on books(pagecount);
cluster books using books_pagecount_idx;

-- Why does > or < not use an index?
--- Sorting of the index?
---- Indices are automatically sorted on creation
---- so sorting isn't the issue

create index on agent(agent_id);

-- Uses index
explain select * from agent where agent_id = 5;

-- Doesn't use it
explain select * from agent where agent_id > 5;

-- Uses it
explain select * from agent where agent_id < 5;

-- This depends on thh 'selectivity' of the index,
-- esseintailly how many items it would return. An id
-- less than 5 wouldn't return many items, so the
-- index will be used.

explain analyze select * from agent where agent_id = 5;

----------------------------------------

-- Disk bound --> primary time taken is form loading 
--				  from the disk to active memory


-- For Page-oriented nest loops, is it better
-- to have the larger table, by pages, in the
-- outer or inner position?

-- for each page of rows a in A do
--	for each page of rows b in B do
--		if ai == bj then add <a, b> to result

-- Authors has 1000 pages, Books has 500
-- Authors has 100 rows per page, books has 80
-- M + M * N

select 1000 + 1000 * 500 as Larger_Outer, 
	   500 + 500 * 1000 as Smaller_Outer;

-- Smaller is better to have outside, larger on inside

