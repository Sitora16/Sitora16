--1
select concat (emp_id, '-', first_name, ' ', last_name) as Fullname from employees
where first_name='Steven' and last_name='King';

--2
select * from Employeeees
Update Employeeees
set phone_number = replace(phone_number, 124, 999) from Employees

--3
Select Firstname as firstname,
       Len (firstname) as namelength from Employees
where firstname like 'A%'
      or firstname like 'J%'
	  or firstname like 'M%'
Order by firstname

--4
Select departmentname, sum(salary) from Employees
Group by departmentname

--5
select * from TestMax
Select ceiling(max1),(max2),(max3)from TestMax

--6
Select * from cinema
where id %2=1 and description not like '%boring%'


--7
select * from SingleOrder
Order by case
             when Id=0 then 1 else 0
			 end;

 --8
 Select coalesce (ssn, passportid, itin) as nulll from person
 
 --9
SELECT
  fullname,
  SUBSTRING(fullname, 1, CHARINDEX(' ', fullname) - 1) AS first_name,
  SUBSTRING(
   fullname,
   CHARINDEX(' ', fullname) + 1,
   CHARINDEX(' ', fullname, CHARINDEX(' ', fullname) + 1) - CHARINDEX(' ', fullname) - 1
  ) AS middle_name,
  SUBSTRING(
  fullname,
  CHARINDEX(' ', fullname, CHARINDEX(' ', fullname) + 1) + 1,
  LEN(fullname)
  ) AS last_name
FROM students;

--10
select * from orders
where deliverystate='tx' and customerid in (select distinct customerid from orders where deliverystate='ca');


--11
select sequencenumber, string_agg (string, ',  ') as names from dmltable
Group by SequenceNumber

--12
select * from Employeeees
where len (concat(FIRST_NAME, LAST_NAME))-
      len (replace(lower(concat (FIRST_NAME, LAST_NAME)),'a', ' '))>=3;

--13
select * from Employeeees
select department_id, count(*) as totalemployeeees,
       100.0 * sum(case when hire_date > 3 then 1 else 0 end)/count(*) as 3years from employeeees
	   group by department_id;

--14
select JobDescription, min (missioncount) as leastexp,
                       max (missioncount) as mostexp from Personal
Group by jobdescription

--15
DECLARE @str NVARCHAR(100) = 'tf56sd#%OqH';
DECLARE @i INT = 1;
DECLARE @len INT = LEN(@str);
DECLARE @ch CHAR(1);

DECLARE @Uppercase NVARCHAR(100) = '';
DECLARE @Lowercase NVARCHAR(100) = '';
DECLARE @Numbers NVARCHAR(100) = '';
DECLARE @Others NVARCHAR(100) = '';

WHILE @i <= @len
BEGIN
    SET @ch = SUBSTRING(@str, @i, 1);
    
    IF @ch COLLATE Latin1_General_CS_AS BETWEEN 'A' AND 'Z'
        SET @Uppercase += @ch;
    ELSE IF @ch COLLATE Latin1_General_CS_AS BETWEEN 'a' AND 'z'
        SET @Lowercase += @ch;
    ELSE IF @ch BETWEEN '0' AND '9'
        SET @Numbers += @ch;
    ELSE
        SET @Others += @ch;

    SET @i += 1;
END

SELECT 
    @Uppercase AS Uppercase_Letters,
    @Lowercase AS Lowercase_Letters,
    @Numbers AS Numbers,
    @Others AS Other_Characters;

--16
select StudentID, FullName, sum(grade)over(order by studentid) as runningtotal from Students

--17
CREATE FUNCTION EvaluateExpression (@expr NVARCHAR(MAX))
RETURNS FLOAT
AS
BEGIN
    DECLARE @result FLOAT;
    DECLARE @sql NVARCHAR(MAX);

    SET @sql = 'SELECT @res = ' + @expr;
    EXEC sp_executesql @sql, N'@res FLOAT OUTPUT', @res = @result OUTPUT;

    RETURN @result;
END
SELECT 
    equation,
    dbo.EvaluateExpression(equation) AS result
FROM Equations;

--18
Select Birthday,count(*) as samebirthday from Student
Group by Birthday having count(*)>1
order by Birthday

--19
select 
      case 
	      when playerA<playerB then playerA+ 'vs' +PlayerB else playerB+ 'vs' +PlayerA
		  end as pair,
		  sum(score) as totalscore
from Playerscores
Group by case
              when playerA<playerB then playerA+ 'vs' +PlayerB else  playerB+ 'vs' +PlayerA
		  end 
Order by pair
