/* cap input rows for the captured run */
options obs=100 nodate nonumber;

/* Mock Employees table matching the schema stated for Q7 in SQL_PREP.sas:
   EmployeeID, Name, ManagerID, JoinDate (ManagerID references EmployeeID). */
data Employees;
    length Name $8;
    input EmployeeID Name $ ManagerID JoinDate :date9.;
    format JoinDate date9.;
    datalines;
1 Alice  . 01JAN2015
2 Bob    1 15MAR2018
3 Chris  1 10FEB2014
4 David  2 20JUL2019
5 Eve    2 05JAN2016
;
run;
