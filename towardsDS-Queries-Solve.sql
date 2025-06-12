/* Problem 1 - Write a SQL query to get the second highest salary from the Employee table. 
For example, given the Employee table below, the query should return 200 as the second highest salary. 
If there is no second highest salary, then the query should return null.
+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
*/

SELECT IFNULL(
    SELECT Salary FROM Employee
    ORDER BY Salary DESC
    LIMIT 1 OFFSET 1, NULL)as SecondHighestSalary 
FROM Employee
LIMIT 1

/* Alt Solution */
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employee
WHERE Salary != (SELECT MAX(Salary) FROM Employee)

/*Problem 2 - Write a SQL query to find all duplicate emails in a table named Person.
+----+---------+
| Id | Email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
*/
SELECT Email, COUNT(*) AS EmailCount 
FROM Person
GROUP BY Email
HAVING EmailCount > 1

/* Alt Solution */
SELECT Email
FROM (
    SELECT Email, COUNT(Email) AS EmailCount
    FROM Person
    GROUP BY Email
) as EmailCount
WHERE EmailCount > 1
