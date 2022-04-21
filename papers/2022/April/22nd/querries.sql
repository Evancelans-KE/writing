--CREATE DATABASE 

CREATE DATABASE hospital_db;

SHOW DATABASES

--create tables #

CREATE TABLE patients_table (patient_id int, p_name varchar(255),p_location varchar(255),p_phone varchar(255), p_email varchar(255), p_dob date, p_visit_date date, is_new bool);

CREATE TABLE appointments_table (app_id int, appointment_date date, patient_id int, doctor_id varchar(255), is_repeat bool);
 

 --INSERT RECORDS

 insert into patients_table (patient_id, p_name,p_location,p_phone,p_email,p_dob,p_visit_date,is_new) values('001','alex','Rivers','+12345678','alexis@dummy.com','1974-04-01','2022-04-03','Y')