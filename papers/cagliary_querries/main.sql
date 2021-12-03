select  median(grade_1),median(grade_2),median(grade_3),median(grade_4),median(grade_5),median(grade_6),median(grade_8),
median(grade_8),median(grade_9),median(grade_10),median(grade_11),median(grade_12),
avg(grade_1),avg(grade_2),avg(grade_3),avg(grade_4),avg(grade_5),avg(grade_6),avg(grade_8),avg(grade_8),avg(grade_9),
avg(grade_10),avg(grade_11),avg(grade_12)
from school_e_data
where school_year ='2014_2015' and school_year = '2019-2020'
group by grade1_grade_2,grade_3,grade_4,grade_5,grade_6,grade_8,grade_8,grade_9,grade_10,grade_11,grade_12