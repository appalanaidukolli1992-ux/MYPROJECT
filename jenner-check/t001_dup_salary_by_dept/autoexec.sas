/* cap input rows for the captured run */
options obs=100 nodate nonumber;

/* Mock Employees table built from the worked example in SQL_PREP.sas
   (the "Rows in Group" sample: HR/50000 Mark,Tom; Sales/60000 Jane,Bob;
   Sales/75000 Alice; IT/80000 Chris,David; HR/55000 Eve). */
data Employees;
    length Name $12 Department $8;
    input Name $ Department $ Salary;
    datalines;
Mark  HR    50000
Tom   HR    50000
Jane  Sales 60000
Bob   Sales 60000
Alice Sales 75000
Chris IT    80000
David IT    80000
Eve   HR    55000
;
run;
