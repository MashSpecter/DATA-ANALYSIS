create database hr;

use projects;

create table human_resources;

create table hur 
like human_resources;

select *
from hur;

with duplicate_cte as(             -- TO FIND DUPLICATES STORE ROW NUMBER INTO ROW_NUM         
select *,
row_number() over(
partition by emp_id, first_name, last_name, birthdate, gender, race, department, jobtitle, location, hire_date, termdate, location_city, location_state) AS row_num
from hur
)
select *                       
from duplicate_cte
where row_num > 1 ;



CREATE TABLE `hur2` (                         -- NEW TABLE TO REMOVE ROWS 
  `emp_id` varchar(20) DEFAULT NULL,
  `first_name` text,
  `last_name` text,
  `birthdate` text,
  `gender` text,
  `race` text,
  `department` text,
  `jobtitle` text,
  `location` text,
  `hire_date` text,
  `termdate` text,
  `location_city` text,
  `location_state` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


insert hur2                                                              -- DATA INSERTED INTO NEW TABLE WITH DUPLICATES ROW NUMBER AS ROWS IN NEW COLUMN 
select *,
row_number() over(
partition by emp_id, first_name, last_name, birthdate, gender, race, department, jobtitle, location, hire_date, termdate, location_city, location_state) AS row_num
from hur;



select *
from hur2;

select *
from hur2
where row_num>1;

delete
from hur2                                      -- ROWS DELETED DUPLICATE
where row_num>1;

-- duplicates removed from dataset
-- now standardizing data using trim , distinct 

select distinct(department)
from hur2;

select department, trim(department)
from hur2;

-- unmark safe updates from edit/preferences/mysqleditior/safeupdates 

update hur2 
set department= trim(department);

select distinct(jobtitle)
from hur2;

select jobtitle, trim(jobtitle)
from hur2;

update hur2 
set jobtitle= trim(jobtitle);

-- NOW CHANGING DATE FORMAT AND DATA TYPE 

-- FOR BIRTHDATE FORMATTING

SET sql_safe_updates = 0;

UPDATE hur2
SET birthdate = STR_TO_DATE(birthdate, '%d-%m-%Y')
WHERE birthdate LIKE '__-__-____';


UPDATE hur2
SET birthdate = CASE
    WHEN birthdate LIKE '%/%' THEN STR_TO_DATE(birthdate, '%m/%d/%Y')
    ELSE birthdate -- Keep original value if it doesn't match
END
WHERE birthdate IS NOT NULL AND birthdate != '';

select birthdate
from hur2;

alter table hur2
modify birthdate date;

-- NOW HIRE_DATE USING SAME STRUCTURE TO CHANGE

select hire_date
from hur2;

set sql_safe_updates =0;

update hur2
set hire_date=str_to_date(hire_date,'%d-%m-%y')
where hire_date like '__-__-____';

update hur2
set hire_date = case
	when hire_date like '%/%' then str_to_date(hire_date,'%m/%d/%y')
    else hire_date 
end 
where hire_date is not null and hire_date != '' ;
   
ALTER TABLE hur2
MODIFY COLUMN hire_date DATE;

-- NOW TERM DATE USING SAME STRUCTURE 


select termdate
from hur2;

SET sql_safe_updates = 0;

UPDATE hur2
SET termdate = STR_TO_DATE(termdate, '%d-%m-%Y')
WHERE termdate LIKE '__-__-____'; 

UPDATE hur2
SET termdate = CASE
    WHEN termdate LIKE '%/%' THEN STR_TO_DATE(termdate, '%m/%d/%Y %H:%i:%s UTC') 
    ELSE termdate -- Keeps original value if it doesn't match
END
WHERE termdate IS NOT NULL AND termdate != '' ;

ALTER TABLE hur2
MODIFY COLUMN termdate DATE;
 
-- CREATE NEW COLUMN NAME AGE
 
alter table hur2
add column age int not null ;

update hur2
set age = timestampdiff(year,birthdate,curdate());

select age 
from hur2;





















    
    
    
    






































































































































































































































































































































































































































