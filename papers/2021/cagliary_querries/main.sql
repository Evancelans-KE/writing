 select * from temp_tbl_2bd_failed_bnks;
 ---
select closing_date, count(*) from temp_tbl_2bd_failed_bnks
group by closing_date 
order by closing_date desc 

-----
select bank, updated_date from temp_tbl_2bd_failed_bnks
where closing_date >='2012-01-01'
order by updated_date desc 