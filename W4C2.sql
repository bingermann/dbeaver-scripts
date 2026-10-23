-- Find the title of the book swith the longest 
-- page count
select b.title, b.pagecount
from books b
where b.pagecount = 
				(select max(b2.pagecount)
				from books b2);