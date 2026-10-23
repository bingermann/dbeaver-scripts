-- Find the number of books by each author
-- Return authorid and count
select books.authorid, count(*)
from books
group by authorid;

-- Return author name
select authors.name, count(*)
from books
join authors on books.authorid = authors.id
group by authors.name;


-- Find publishers with 2 or more books
-- Return pubid and count
select p.id, count(*)
from publishers p
join books b on p.id = b.pubid
group by p.id
having count(*) >= 2;

-- Return the publisher name
select p.name, count(*)
from publishers p
join books b on p.id = b.pubid
group by p.name
having count(*) >= 2;





