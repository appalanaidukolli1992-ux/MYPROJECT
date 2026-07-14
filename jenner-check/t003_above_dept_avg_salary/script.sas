/* Q18 from SQL_PREP.sas: "What is a correlated subquery...?" — the worked
   example that returns employees whose salary exceeds their department
   average, run as PROC SQL. */
proc sql;
    create table above_dept_avg as
    select
        e.employee_id,
        e.department_id,
        e.salary
    from Employees e
    where e.salary > (
        select avg(s.salary)
        from Employees s
        where s.department_id = e.department_id
    )
    order by e.department_id, e.salary desc;
quit;

proc print data=above_dept_avg noobs;
    title "Employees earning above their department average";
run;
