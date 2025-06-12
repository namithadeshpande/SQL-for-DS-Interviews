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

/* This Solution does not work when two rows have same value */  
SELECT IFNULL(
    (SELECT Salary FROM Employee
    ORDER BY Salary DESC
    LIMIT 1 OFFSET 1), NULL)as SecondHighestSalary 
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
SELECT Email
FROM Person
GROUP BY Email
HAVING COUNT(Email) > 1

/* Alt Solution */
SELECT Email
FROM (
    SELECT Email, COUNT(Email) AS EmailCount
    FROM Person
    GROUP BY Email
) as EmailCount
WHERE EmailCount > 1

/* Problem 3 - Given a Weather table, write a SQL query to find all dates’ 
Ids with higher temperature compared to its previous (yesterday’s) dates.

+---------+------------------+------------------+
| Id(INT) | RecordDate(DATE) | Temperature(INT) |
+---------+------------------+------------------+
|       1 |       2015-01-01 |               10 |
|       2 |       2015-01-02 |               25 |
|       3 |       2015-01-03 |               20 |
|       4 |       2015-01-04 |               30 |
+---------+------------------+------------------+
*/

SELECT W1.id
FROM Weather W1
JOIN Weather W2
ON DATEDIFF(W1.recordDate, W2.recordDate) = 1
AND W1.temperature > W2.temperature

/* The Employee table holds all employees. 
Every employee has an Id, a salary, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who have the highest salary in each of the departments. 
For the above tables, your SQL query should return the following rows (order of rows does not matter).

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
*/

# Write your MySQL query statement below
SELECT D.name as Department, E.name as Employee, E.salary as Salary
FROM EMPLOYEE E
JOIN DEPARTMENT D 
ON E.departmentId = D.id
WHERE (DepartmentId, salary)
IN(
    SELECT departmentId, MAX(salary)
    FROM Employee
    GROUP BY departmentId
)

/* Problem 5 - Mary is a teacher in a middle school and 
she has a table seat storing students’ names and their corresponding seat ids. 
The column id is a continuous increment. Mary wants to change seats for the adjacent students.

Can you write a SQL query to output the result for Mary?
+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Abbot   |
|    2    | Doris   |
|    3    | Emerson |
|    4    | Green   |
|    5    | Jeames  |
+---------+---------+
For the sample input, the output is:
+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Doris   |
|    2    | Abbot   |
|    3    | Green   |
|    4    | Emerson |
|    5    | Jeames  |
+---------+---------+
Note: If the number of students is odd, there is no need to change the last one’s seat.
*/

