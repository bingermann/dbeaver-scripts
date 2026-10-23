-- Write a query to find titles of Books and the 
-- names of their

select books.title, authors.name
from books
left join authors on books.authorid = authors.id


-- Write one query to list the titles of Books and 
-- the names of their Authors; include Books 
-- without an author and Authors without a
-- book

select books.title, authors.name
from books
full join authors on books.authorid = authors.id



--Bonus questions: Write a query to find only the 
-- Titles of Books without an Author

select books.title, authors.name
from books 
join authors on books.authorid = authors.id 
where authors.name is NULL


