/* Q7 from SQL_PREP.sas: "How can you find employees who joined before their
   manager?" — the self-join on Employees, run as PROC SQL. */
proc sql;
    create table joined_before_mgr as
    select
        e.Name     as Employee,
        m.Name     as Manager,
        e.JoinDate as EmployeeJoin format=date9.,
        m.JoinDate as ManagerJoin  format=date9.
    from Employees e
    join Employees m
      on e.ManagerID = m.EmployeeID
    where e.JoinDate < m.JoinDate;
quit;

proc print data=joined_before_mgr noobs;
    title "Employees who joined before their manager";
run;
