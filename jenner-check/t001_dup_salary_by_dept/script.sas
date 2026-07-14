/* Q1 from SQL_PREP.sas: "How do you find employees with the same salary
   within a department?" — the second (aliased-count) form, run as PROC SQL. */
proc sql;
    create table dup_salary as
    select
        Department,
        Salary,
        count(*) as NumberOfEmployees
    from Employees
    group by Department, Salary
    having count(*) > 1;
quit;

proc print data=dup_salary noobs;
    title "Departments+salaries shared by more than one employee";
run;
