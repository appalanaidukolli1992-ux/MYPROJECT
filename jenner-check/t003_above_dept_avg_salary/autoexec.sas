/* cap input rows for the captured run */
options obs=100 nodate nonumber;

/* Mock Employees table matching the schema used in Q18 of SQL_PREP.sas:
   employee_id, department_id, salary. */
data Employees;
    input employee_id department_id salary;
    datalines;
1 10 50000
2 10 70000
3 10 60000
4 20 90000
5 20 65000
6 20 80000
7 30 55000
8 30 55000
;
run;
