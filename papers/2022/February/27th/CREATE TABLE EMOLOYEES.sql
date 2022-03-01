CREATE TABLE EMOLOYEES
(
EMPLOYEE_ID INT,
SSN VARCHAR(255),
FNAME VARCHAR(255),
LNAME VARCHAR(255),
POSITION VARCHAR(255),
SALARY INT,
PHONENUM VARCHAR(255)
)

SELECT * FROM EMPLOYEES

----

INSERT INTO EMPLOYEES(EMPLOYEE_ID,SSN,FNAME,LNAME,POSITION,SALARY,PHONENUM)
VALUES
('100','111-11-0607', 'John','Smith', 'Manager', '35000.75', '800-350-0000'),
('200','333-22-0607','John','Jones','Associate','25000.00','202-999-0000'),
('300','444-44-0607','Sally','Smith','Manager','46500.00','303-999-0000') 

----------------

INSERT INTO EMPLOYEES(EMPLOYEE_ID,SSN,FNAME,LNAME,POSITION,SALARY,PHONENUM)
VALUES
('500','111-23-0607','Samaria','Alexis','Developer','36900', '800-571-0000')


-----------------------

SELECT EMPLOYEE_ID, FNAME,LNAME,POSITION,SALARY FROM EMPLOYEES;


------------------------

SELECT EMPLOYEE_ID, FNAME,LNAME,POSITION,SALARY,PHONENUM FROM EMPLOYEES
WHERE SALARY >20000

--------------------------------

SELECT EMPLOYEE_ID, FNAME,LNAME,POSITION,SALARY FROM EMPLOYEES
WHERE SALARY >20000 AND SALARY <45000

----------------------------------------

