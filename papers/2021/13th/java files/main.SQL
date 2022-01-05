CREATE TABLE trips
(
trip_id INT,
trip_name VARCHAR(255),
trip_master VARCHAR(255),
trip_location VARCHAR(25),
trip_date TIMESTAMP,
student_id INT,
);

SELECT * FROM trips;

---GAMES TABLE 

CREATE TABLE games
(
game_id INT,
game_name VARCHAR(255),
game_location INT,
student_id INT,
game_date  TIMESTAMP(25),
teacher_id INT
);

SELECT * FROM  games;

--GRANTING user access

GRANT SELECT ON class to user  miniadmin;

--NORMAL SQL querries 

SELECT * FROM class;

--

SELECT * FROM class
WHERE name = 'Four'
AND capacity = '500'

--INSERTING INTO CLASS

insert into stduents
(id,s_name,class_id,subject_id)
values
('101','jeremy lynch','10001','201'),
('102','Llian Ace','10002','202'),

----
--UPDATE STUDENTS TABLE WITH NEW SUBJECT ID RECORD AS 202

update table students set subject_id = '202' where id = '101'

----
TRUNCATE TABLE subjects immediate;
THEN 
select * from subjects;

----
DROP TABLE subjects;