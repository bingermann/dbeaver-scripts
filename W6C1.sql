-- On delete cascade assures that the now irrelevent
-- employee data is deleted when it's ssn is removed

CREATE TABLE Dependents (
						ssn char(11),
						dname text,
						date-of-birth date
						PRIMARY KEY (dname, ssn),
						FOREIGN KEY (ssn) REFERENCES Employee, ON DELETE CASCADE);


----- MIDTERM QUESTIONS -----

-- For Q1-Q4: state in plain English what it computes 
-- and then give its full result on the database instance 
-- above.


-- Question 1: 

SELECT Books.Title, Authors.Name AS AuthorName
FROM Books
JOIN Authors ON Books.AuthorId = Authors.Id
WHERE Books.Genre = 'Horror';

-- A1: 



-- Question 2:

SELECT AVG(PageCount) AS AvgPages, MAX(PageCount) AS MaxPages
FROM Books;

-- A2:



-- Question 3:

SELECT Title, PageCount
FROM Books B1
WHERE B1.PageCount > SOME (
    SELECT B2.PageCount
    FROM Books B2
    WHERE Genre = 'Horror');

-- A3:



-- Question 4:

SELECT PubId, COUNT(*) AS TotalBooks, SUM(PageCount) AS TotalPages 
FROM Books 
GROUP BY PubId 
HAVING COUNT(*) > 1; 

-- A4:



SELECT b.PubId, COUNT(*)
FROM Books b
GROUP BY b.PubId
HAVING COUNT(*) > 100;


