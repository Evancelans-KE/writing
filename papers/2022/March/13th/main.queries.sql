 --a 

SELECT store AS Expr1, Count(*) AS Expr2
FROM [orders and sales]
GROUP BY store;

--b 

SELECT 
store, count(*)
FROM purchases
group by store;

--c 

SELECT 
customer, sum(rcpt_amt)
FROM [cash receipts]
group by customer
order by sum(rcpt_amt) DESC

--d 
SELECT 
a.grower, (b.qty_purch * purchase_price) as total_purchase
FROM purchases a 
LEFT OUTER JOIN  [orders and sales items] b 
on a.purchase = b.purchase
group by total_purchase, a.grower
order by total_purchase desc;

--e

SELECT * FROM PURCHASES_ITEMS WHERE purchase_price IS NULL ;


----

SELECT
rcpt_date, count(*)
FROM [cash receipts] group by rcpt_date



SELECT 
FROM employees;

--7b

SELECT
* 
FROM inventory 
ORDER BY Retail_Price ASC;


--7C 

SELECT COUNT(*) FROM 
(SELECT COUNT(*) FROM FROM inventory 
WHERE Retail_Price = 6.0) C 


----7d 


SELECT 
FROM purchases INNER JOIN [purchase items] ON purchases.[purchase#] = [purchase items].[purchase#]