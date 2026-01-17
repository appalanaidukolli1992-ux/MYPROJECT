SQL queations:

1️⃣ How do you find employees with the same salary within a department?
SELECT Department, Salary
FROM Employees
GROUP BY Department, Salary
HAVING COUNT(*) > 1;


Group,Department,Salary,Rows in Group
G1,HR,50000,"Mark, Tom"
G2,Sales,60000,"Jane, Bob"
G3,Sales,75000,Alice
G4,IT,80000,"Chris, David"
G5,HR,55000,Eve

OR
SELECT
    Department,
    Salary,
    COUNT(*) AS NumberOfEmployees
FROM
    Employees
GROUP BY
    Department,
    Salary
HAVING
    COUNT(*) > 1;



 2️⃣ How can you remove rows that have NULL values in specific columns?
   Where is not null condition
 
 3️⃣ What’s the difference between INNER JOIN and CROSS JOIN?
    INNER JOIN

Returns only matching rows between tables based on a condition (ON clause).
✅ Used to combine related data.

Example: Employees and their Departments (only if department exists)

CROSS JOIN

Returns all possible combinations of rows between both tables — no condition needed.
⚠️ Can explode to thousands/millions of rows.

Example: 5 Employees × 3 Shifts = 15 combinations

In one line:

INNER JOIN = meaningful matches
CROSS JOIN = every possible combination (cartesian product) ✅
------------------

 4️⃣ When should you use GROUP BY vs PARTITION BY?
 GROUP BY = summary table
 PARTITION BY = summary + detailed rows together
 GROUP BY (collapses rows)

SELECT Department, SUM(Salary)
FROM Employees
GROUP BY Department;


✅ Output: Only 1 row per department

PARTITION BY (keeps all rows, just adds info)

SELECT Name, Department, Salary,
       SUM(Salary) OVER (PARTITION BY Department) AS DeptTotal
FROM Employees;


✅ Output: Shows every employee, but with department total added
-----------------------------
 5️⃣ How do you find records that exist in both tables?
 Inner joine
 SELECT e.*
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID;
---------------------------
 6️⃣ How do you fetch the top 3 highest-paid employees in each department?
 
 WITH RankedEmployees AS (
    SELECT Name, Department, Salary,
           RANK()/ROW_NUMBER OVER (PARTITION BY Department ORDER BY Salary DESC) AS rnk
    FROM Employees
)
SELECT Name, Department, Salary
FROM RankedEmployees
WHERE rnk <= 3;


------------------------
 7️⃣ How can you find employees who joined before their manager?
 You can find employees who joined before their manager by using a self-join on the Employees table.

Assumptions:

Table: Employees

Columns: EmployeeID, Name, ManagerID, JoinDate

Here, ManagerID is the EmployeeID of the employee’s manager.
 SELECT e.Name AS Employee, m.Name AS Manager, e.JoinDate AS EmployeeJoin, m.JoinDate AS ManagerJoin
FROM Employees e
JOIN Employees m
  ON e.ManagerID = m.EmployeeID
WHERE e.JoinDate < m.JoinDate;

-------------------------------------

 8️⃣ What’s the key difference between EXISTS and IN?
 1️⃣ IN

Checks if a value matches any value in a list or subquery.
EXISTS

Checks if the subquery returns any rows at all.
 Use IN for simple value sets.

Use EXISTS for row existence checks, especially if subquery depends on outer query.

SELECT Name 
FROM Employees e
WHERE EXISTS (
    SELECT 1 
    FROM Departments d
    WHERE d.DepartmentID = e.DepartmentID 
      AND d.Location = 'NY'
);

------------------------
 9️⃣ How would you replace specific string values in a column using SQL?
 Replace funrion
 SELECT Name,
       REPLACE(Name, 'Alice', 'Alicia') AS UpdatedName
FROM Employees;

-----------------------

 🔟 How does the ORDER BY clause impact query performance?
 
 Yes, bca it connects inmemory usage.ORDER BY forces the database to sort the result set before returning it.

Sorting can be CPU and memory intensive, especially if there are:
---------------------------
 1️⃣1️⃣ How do you fetch every 5th record from a table?
 SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY EmployeeID) AS rn
    FROM Employees
) t
WHERE rn % 5 = 0;

or 
SELECT * FROM Employees ORDER BY EmployeeID LIMIT 1 OFFSET 4;
SELECT * FROM Employees ORDER BY EmployeeID LIMIT 1 OFFSET 9;

-------------------
 1️⃣2️⃣ What’s the difference between aggregate and analytic functions in SQL?
 Aggregate functions collapse multiple input rows into one output row. Example: SUM, COUNT, MAX, MIN, AVG. They require GROUP BY or operate on the whole result set.

Analytic (window) functions keep the number of rows the same. They compute values across related rows but still output one result per row. Example: SUM(...) OVER (...), ROW_NUMBER(), LAG, LEAD. They do not require GROUP BY and do not collapse.

-------------------
 1️⃣3️⃣ How do you unpivot columns into rows in SQL?
 
 UNpivot method
 --------------------
 
 1️⃣4️⃣ How do you calculate percentage contribution per department?
 SELECT
  department,
  SUM(sales) AS dept_sales,
  100.0 * SUM(sales)
    / SUM(SUM(sales)) OVER () AS pct_contribution
FROM sales_table
GROUP BY department;

------------------

 1️⃣5️⃣ How would you identify missing sequence numbers in a column?
 -------
 1️⃣6️⃣ What’s the difference between a temporary table and a CTE?
  temp is physical object, CTE is logical set .
  temp table is physical and lasts across statements. CTE is logical and lasts one statement.
 CTE nothing but With As(): temp table create TEMP table table, for temprory usage with in store procs something
 ------------------
 1️⃣7️⃣ How do you detect gaps in date ranges for each employee?
 1️⃣8️⃣ What is a correlated subquery, and when would you use it?
 A correlated subquery references columns from the outer query. It is re-evaluated once per outer row.
 calculating employess whose average salry is greatre then in departmetn
 SELECT e.employee_id,
       e.salary
FROM employees e
WHERE e.salary > (
  SELECT AVG(salary)
  FROM employees s
  WHERE s.department_id = e.department_id
);

--------------------------
 1️⃣9️⃣ How do you find the most recent record for each category in a table?
 2️⃣0️⃣ How do you improve performance for a query using indexes?

SQL is powerful, but the right questions make you think beyond the basics. Which of these do you find the trickiest? Let’s discuss!