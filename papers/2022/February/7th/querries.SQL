--Natural join syntax;
 SELECT * FROM TABLE_NAME_1 NATURAL JOIN TABLE_NAME_2;

--LEFT OUTER JOIN 
SELECT * FROM TABLE_NAME_1 a 
LEFT OUTER JOIN TABLE_NAME_2 b
ON a.TABLE_NAME_1.id = b.TABLE_NAME_2.id 
WHERE --{pass condition here..}

--RIGHT OUTER JOIN 

SELECT * FROM TABLE_NAME_2 a 
LEFT OUTER JOIN TABLE_NAME_1 b 
ON a.TABLE_NAME_1.id = b.TABLE_NAME_2.id 
WHERE --{pass condition here..}

----Solution One

select * from "Truck" natural join base;

---Solution Two
select * from "Truck" a 
left  join base b 
on a.base_code = b.base_code 

--Solution three
select * from base a 
right  join "Truck"  b 
on a.base_code = b.base_code 