
  -- 1. WHAT IS THE GENDER BREAKDOWN OF EMPLOYEE IN THE COMPANY
  
  select gender,count(*) as count
  from hur2
  where termdate = (0000-00-00)
  group by gender;
  
  -- 2. What is the race/ethnicity breakdown of employees in the company?
  
  select race,count(*) as count
  from hur2
  where termdate = (0000-00-00)
  group by race;
  
  -- 3. How many employees work at headquarters versus remote locations?
  
  select location,count(*) as count
  from hur2
  where termdate = (0000-00-00)
  group by location;
  
  -- 4. What is the average length of employment for employees who have been terminated?
  
  SELECT ROUND(AVG(DATEDIFF(termdate, hire_date)) / 365, 0) AS avg_employment
  FROM hur2
  WHERE termdate <> (0000-00-00)
  AND termdate <= CURDATE();
  
  -- 5. How does the gender distribution vary across departments and job titles?

  select department ,gender,count(*) as count
  from hur2
  group by department,gender
  order by department;
  
  -- 6. 6. What is the distribution of job titles across the company by department maximum employees and minimum employees breakdown?
  
  select jobtitle,count(*) as count
  from hur2
  where termdate=(0000-0000-0000)
  group by jobtitle
  order by jobtitle desc;
  
  -- 7. What is the distribution of employees across locations by state?
  
  select location_state,count(*) as count
  from hur2
  where termdate=(0000-0000-0000)
  group by location_state
  order by location_state;
  

  
   


  
  


  
  




  
  
  
  
  
  
  
  
  

  