select * from abalone;

select * from abalone where water_region like '%Florida Atlantic Coast%'

select * from abalone where  shell_weight = '0.01'

select * from abalone where  feb_temp > '12.3'

insert into abalone
(gender, length, diameter, height,whole_weight,shucked_weight,viscera_weight,shell_weight,rings,collector,water_region,feb_temp)
values('M','0.71','0.555','0.195','1.9485','0.9455','0.3765','0.495','12','Jan Odom, University of Houston','Florida Atlantic Coast',' 71.8 degrees Fahrenheit');


select * from abalone where collector = 'Jan Odom, University of Houston';


delete  from abalone where  whole_weight  > '2'
select * from abalone as ab ;
