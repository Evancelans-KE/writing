CREATE TABLE employees (
    emp_no      INT             NOT NULL,
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender       VARCHAR(16)   NOT NULL,    
    hire_date   DATE            NOT NULL,
    PRIMARY KEY (emp_no)
);


CREATE TABLE departments (
    dept_no     VARCHAR(40),
    dept_name   VARCHAR(40)

);



CREATE TABLE dept_manager (
   emp_no       INT             NOT NULL,
   dept_no      VARCHAR(40)         NOT NULL,
   from_date    DATE            NOT NULL,
   to_date      DATE            NOT NULL,
   PRIMARY KEY (emp_no,dept_no)
);


CREATE TABLE titles (
    emp_no      INT             NOT NULL,
    title       VARCHAR(50)     NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,title, from_date)
) 
;


CREATE TABLE SALARIES (
    emp_no      INT             NOT NULL,
    salary      INT             NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no, from_date)
) 
; 


CREATE  VIEW dept_emp_latest_date AS
SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
FROM dept_emp
GROUP BY emp_no;



SELECT * FROM EMPLOYEES 

INSERT INTO EMPLOYEES 
VALUES ('10001','1953-09-02','Georgi','Facello','M','1986-06-26'),
('10002','1964-06-02','Bezalel','Simmel','F','1985-11-21'),
('10003','1959-12-03','Parto','Bamford','M','1986-08-28'),
('10004','1954-05-01','Chirstian','Koblick','M','1986-12-01'),
('10005','1955-01-21','Kyoichi','Maliniak','M','1989-09-12'),
('10006','1953-04-20','Anneke','Preusig','F','1989-06-02'),
('10007','1957-05-23','Tzvetan','Zielinski','F','1989-02-10'),
('10008','1958-02-19','Saniya','Kalloufi','M','1994-09-15'),
('10009','1952-04-19','Sumant','Peac','F','1985-02-18'),
('10010','1963-06-01','Duangkaew','Piveteau','F','1989-08-24'),
('10011','1953-11-07','Mary','Sluis','F','1990-01-22'),
('10012','1960-10-04','Patricio','Bridgland','M','1992-12-18'),
('10013','1963-06-07','Eberhardt','Terkki','M','1985-10-20'),
('10014','1956-02-12','Berni','Genin','M','1987-03-11'),
('10015','1959-08-19','Guoxiang','Nooteboom','M','1987-07-02'),
('10016','1961-05-02','Kazuhito','Cappelletti','M','1995-01-27'),
('10017','1958-07-06','Cristinel','Bouloucos','F','1993-08-03'),
('10018','1954-06-19','Kazuhide','Peha','F','1987-04-03'),
('10019','1953-01-23','Lillian','Haddadi','M','1999-04-30'),
('10020','1952-12-24','Mayuko','Warwick','M','1991-01-26'),
('10021','1960-02-20','Ramzi','Erde','M','1988-02-10'),
('10022','1952-07-08','Shahaf','Famili','M','1995-08-22'),
('10023','1953-09-29','Bojan','Montemayor','F','1989-12-17'),
('10024','1958-09-05','Suzette','Pettey','F','1997-05-19'),
('10025','1958-10-31','Prasadram','Heyers','M','1987-08-17'),
('10026','1953-04-03','Yongqiao','Berztiss','M','1995-03-20'),
('10027','1962-07-10','Divier','Reistad','F','1989-07-07')
 



---------------------------------------------------------------------------------------


INSERT INTO TITLES VALUES 
('10001', 'Senior Engineer','1986-06-26', '9999-01-01'),
('10002','Staff','1996-08-03', '1999-01-01'),
('10003','Senior Engineer',	'1995-12-03',	'9999-01-01'),
('10004','Engineer'	,'1986-12-01'	,'1995-12-01'),
('10004','Senior Engineer'	,'1995-12-01',	'9999-01-01'),
('10005','Senior Staff'	,'1996-09-12',	'9999-01-01'),
('10005','Staff',	'1989-09-12',	'1996-09-12'),
('10006','Senior Engineer'	,'1990-08-05'	,'9999-01-01'),
('10007','Senior Staff',	'1996-02-11',	'9999-01-01'),
('10007','Staff'	,'1989-02-10',	'1996-02-11')


---------------------------------------------------------------------------------------------------

INSERT INTO SALARIES 
VALUES ('10001','60117','1986-06-26','1987-06-26'),
('10001','62102','1987-06-26','1988-06-25'),
('10001','66074','1988-06-25','1989-06-25'),
('10001','66596','1989-06-25','1990-06-25'),
('10001','66961','1990-06-25','1991-06-25'),
('10001','71046','1991-06-25','1992-06-24'),
('10001','74333','1992-06-24','1993-06-24'),
('10001','75286','1993-06-24','1994-06-24'),
('10001','75994','1994-06-24','1995-06-24'),
('10001','76884','1995-06-24','1996-06-23'),
('10001','80013','1996-06-23','1997-06-23'),
('10001','81025','1997-06-23','1998-06-23'),
('10001','81097','1998-06-23','1999-06-23'),
('10001','84917','1999-06-23','2000-06-22'),
('10001','85112','2000-06-22','2001-06-22'),
('10001','85097','2001-06-22','2002-06-22'),
('10001','88958','2002-06-22','9999-01-01'),
('10002','65828','1996-08-03','1997-08-03'),
('10002','65909','1997-08-03','1998-08-03'),
('10002','67534','1998-08-03','1999-08-03'),
('10002','69366','1999-08-03','2000-08-02'),
('10002','71963','2000-08-02','2001-08-02')
 


------------------------------------------------------------------------------------------------

INSERT INTO DEPT_MANAGER 
VALUES 	
('110022','d001','1985-01-01','1991-10-01'),
('110039','d001','1991-10-01','1999-01-01'),
('110085','d002','1985-01-01','1989-12-17'),			
('110228','d003','1992-03-21','1999-01-01'),		
('110303','d004','1985-01-01','1988-09-09'),			
('110344','d004','1988-09-09','1992-08-02'),		
('110386','d004','1992-08-02','1996-08-30'),			
('110420','d004','1996-08-30','9999-01-01'),		
('110511','d005','1985-01-01','1992-04-25')
		

-----------------------------------------------------------------------------------


INSERT INTO `dept_emp` VALUES ('10001',	'd005',	'1986-06-26'	,'9999-01-01'),
('10002',	'd007',	'1996-08-03'	,'9999-01-01'),
('10003',	'd004'	,'1995-12-03'	,'9999-01-01'),
('10004',	'd004'	,'1986-12-01',	'9999-01-01'),
('10005',	'd003',	'1989-09-12'	,'9999-01-01'),
('10006','d005'	,'1990-08-05',	'9999-01-01'),
('10007',	'd008'	,'1989-02-10'	,'9999-01-01'),
('10008',	'd005'	,'1998-03-11'	,'2000-07-31'),
('10009',	'd006'	,'1985-02-18'	,'9999-01-01'),
('10010',	'd004',	'1996-11-24'	,'2000-06-26'),
('10010',	'd006',	'2000-06-26'	,'9999-01-01'),
('10011',	'd009'	,'1990-01-22'	,'1996-11-09'),
('10012',	'd005'	,'1992-12-18'	,'9999-01-01'),
('10013',	'd003'	,'1985-10-20'	,'9999-01-01'),
('10014'	,'d005',	'1993-12-29'	,'9999-01-01'),
('10015',	'd008'	,'1992-09-19'	,'1993-08-22'),
('10016',	'd007'	,'1998-02-11'	,'9999-01-01'),
('10017',	'd001'	,'1993-08-03',	'9999-01-01'),
('10018'	'd004',	'1992-07-29'	,'9999-01-01'),
('10018',	'd005'	,'1987-04-03'	,'1992-07-29'),
('10020',	'd004',	'1997-12-30'	,'9999-01-01'),
('10021',	'd005'	,'1988-02-10'	,'2002-07-15'),
('10022',	'd005'	,'1999-09-03'	,'9999-01-01'),
('10023'	,'d005',	'1999-09-27',	'9999-01-01'),
('10024'	,'d004'	,'1998-06-14'	,'9999-01-01'),
('10025'	,'d005'	,'1987-08-17'	,'1997-10-15'),
('10026'	,'d004'	,'1995-03-20'	,'9999-01-01'),
('10027'	,'d005'	,'1995-04-02'	,'9999-01-01')



-----------------------------------------------------------------------------------------------

INSERT INTO DEPARTMENTS VALUES 	
('d001','Marketing'),
('d002','Finance'),
('d003'	,'Human Resources'),
('d004','Production'),
('d005','Development'),
('d006','Quality Management'),
('d007','Sales'),
('d008','Research'),
('d009','Customer Service')


----------------------------------------------------------------------


SELECT * FROM EMPLOYEES WHERE FIRST_NAME NOT IN ('JOHN','MARK','JACOB')


SELECT * FROM SALARIES WHERE SALARY >=66000 AND SALARY <=70000

SELECT * FROM EMPLOYEES WHERE EMP_NO >= 10004 AND EMP_NO <=10012

CREATE  VIEW new_view AS
SELECT a.FIRST_NAME,a.LAST_NAME,a.GENDER,a.HIRE_DATE,b.TITLE  FROM EMPLOYEES a
LEFT OUTER JOIN TITLES b 
ON a.EMP_NO = b.EMP_NO

 SELECT * FROM new_view

 ----------------------------------------------------------


 SELECT a.*, b.LAST_NAME  FROM DEPT_MANAGER a 
LEFT OUTER JOIN EMPLOYEES b 
ON a.EMP_NO = b.EMP_NO 
WHERE b.LAST_NAME = 'Markovitch'

-------------------------------------------------------------------------

SELECT a.EMP_NO,a.FROM_DATE, b.LAST_NAME,b.HIRE_DATE,c.TITLE,d.DEPT_NAME FROM DEPT_MANAGER a 
LEFT OUTER JOIN EMPLOYEES b 
ON a.EMP_NO = b.EMP_NO 
LEFT OUTER JOIN TITLES c 
ON b.EMP_NO = c.EMP_NO 
LEFT OUTER JOIN DEPARTMENTS d
ON a.DEPT_NO = d.DEPT_NO
 
SELECT * FROM TEMP_SALES 

INSERT INTO TEMP_SALES  
VALUES ('apples','100'),('CHERRIES','200')



 CASE WHEN
   GENDER = ‘F’ THEN ‘FEMALE’
   ELSE ‘MALE’

      ORDER BY GENDER, EMP_NO  ASC

-------------LAB 6 

insert into 
departments (dept_no, dept_name)
values ('d010','Business Analysis');


UPDATE DEPARTMENTS SET DEPT_NAME = 'Data Analysis' WHERE  DEPT_NO = 'd010'


begin atomic
   update DEPARTMENTS set DEPT_NO = 10
   where DEPT_NAME  = 'Data Analysis'
   commit
end@


DELETE  FROM DEPARTMENTS WHERE DEPT_NO = 'd010'


EXEC SQL
COMMIT
END-EXEC

EXEC SQL
DELETE FROM  DEPARTMENTS WHERE DEPT_NOE = 'D010'
END-EXEC

EXEC SQL
ROLLBACK
END-EXEC

 SELECT ROUND(SALARY,2) FROM SALARIES 
 WHERE FROM_DATE >'1997-01-01'
