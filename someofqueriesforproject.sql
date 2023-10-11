              
--using stored procedure for inserting  rows into the donor table
CREATE PROCEDURE Insertdonors2 (
    @id int,
    @name VARCHAR(50),
    @donation_amount decimal(10,2),
      @donation_date date,
  @Phone VARCHAR(20),
    @org_id int
)
AS
BEGIN
    INSERT INTO donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id)
    VALUES (@id, @name, @donation_amount ,@donation_date, @Phone, @org_id)
END

EXEC Insertdonors2
    @id = 15102,
    @name = 'Faustine Walworche',
	@donation_amount = 100.00,
	@donation_date = '2023-01-20',
    @Phone = '599-808-2443',
    @org_id = 3

	EXEC Insertdonors2
    @id = 15103,
    @name = 'Erda Tym',
	@donation_amount = 4291,
	@donation_date = '2/5/2023',
    @Phone = '708-657-3206',
    @org_id = 4

	EXEC Insertdonors2
    @id = 15104,
    @name = 'Quintana Morl',
	@donation_amount = 5393,
	@donation_date = '4/23/2023',
    @Phone = '211-928-1699',
    @org_id = 1

	EXEC Insertdonors2
    @id = 15105,
    @name = 'Gladi Human',
	@donation_amount = 2285,
	@donation_date = '2/17/2023',
    @Phone = '829-324-2755',
    @org_id = 2

	EXEC Insertdonors2
    @id = 15106,
    @name = 'Jude Coulling',
	@donation_amount = 4215,
	@donation_date = '11/17/2022',
    @Phone = '639-926-4154',
    @org_id = 3

--using PROCEDURE that Delete Column donor_mail from donor table

CREATE PROCEDURE DeleteColumn1
AS
BEGIN
    ALTER TABLE donor
    DROP COLUMN donor_mail;
END

EXEC DeleteColumn1;

--using cursor Calculate the total salary for each branch 
--and display the branch name along with the total salary 
DECLARE cur_1 CURSOR
FOR
    SELECT ch.charity_name, SUM(e.salary) AS total_salary
    FROM charity_organization ch
    INNER JOIN employee e ON ch.id = e.org_id
    GROUP BY ch.charity_name
FOR READ ONLY
DECLARE @charname VARCHAR(50), @salary INT
OPEN cur_1
FETCH cur_1 INTO @charname, @salary
WHILE @@fetch_status = 0
BEGIN
    SELECT 'Charity Name: ' + @charname AS CharityName, 'Total Salary: ' + CAST(@salary AS VARCHAR(10)) AS TotalSalary
    FETCH cur_1 INTO @charname, @salary
END
CLOSE cur_1
DEALLOCATE cur_1


--using PROCEDURE that update  employee salaries by increasing them by a certain percentage for a specific branch

CREATE PROCEDURE IncrementEmployeeSalary
AS
BEGIN
    DECLARE @emp_id INT, @salary DECIMAL(10,2), @ch_name VARCHAR(100)

    DECLARE increment_employee CURSOR FOR
        SELECT e.emp_id, e.salary, ch.charity_name
        FROM employee e
        INNER JOIN charity_organization ch ON e.org_id = ch.id
        ORDER BY ch.charity_name

    OPEN increment_employee

    FETCH NEXT FROM increment_employee INTO @emp_id, @salary, @ch_name

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF (@ch_name = 'mersal sinai')
        BEGIN
            SET @salary = @salary + 1000 -- Increment salary by a fixed amount
        END
        ELSE
        BEGIN
            SET @salary = @salary + 500 -- Increment salary by a different fixed amount
        END

        UPDATE Employee
        SET salary = @salary
        WHERE CURRENT OF increment_employee

        FETCH NEXT FROM increment_employee INTO @emp_id, @salary, @ch_name
    END

    CLOSE increment_employee
    DEALLOCATE increment_employee
END
--execute the stored procedure IncrementEmployeeSalary
IncrementEmployeeSalary
--------------------------------------------------------------------------------------------
------------------Some queries to get more information about the charity and help it make decisions----------
--   Create a stored procedure to show name of projects for each branch 

CREATE PROC project_names_per_branch
as
SELECT ch.id , ch.charity_name, p_name
FROM charity_organization ch inner join project p
on ch.id=p.org_id
order by ch.id
--calling of SP
project_names_per_branch

--- Returns  employees with salaries higher than a specified amount.
CREATE FUNCTION Get_High_Salary_Employees(@MinSalary int)
RETURNS TABLE
AS
RETURN
(
    SELECT emp_id, emp_name, Salary
    FROM Employee
    WHERE Salary > @MinSalary
)

SELECT *
FROM dbo.Get_High_Salary_Employees(20000)



--Calculates and returns the total salary of all employees in the each branch.
CREATE FUNCTION Get_Total_Salary22(@branch_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @Total_Salary INT

    SELECT @Total_Salary = SUM(salary)
    FROM employee
    INNER JOIN charity_organization c ON employee.org_id = c.id
    WHERE c.id = @branch_id

    RETURN @Total_Salary
END

SELECT charity_name, dbo.Get_Total_Salary22(id) AS Total_Salary
FROM charity_organization



-----rank employees within each branch based on their salaries

    SELECT org_id, emp_id, Salary,
           ROW_NUMBER() OVER (PARTITION BY org_id ORDER BY Salary DESC) AS Rank
    FROM Employee
	---------volunteers names for each project
select vol_name, p_name ,p_id , row_number() over ( order by p_id ) as rn
from project p inner join charity_organization ch on p.org_id = ch. id 
inner join volunteers v
on ch.id=v.org_id

------------------rank donors within each branch based on their donation amount
    SELECT org_id, donor_id, donation_amount,
           ROW_NUMBER() OVER (PARTITION BY org_id ORDER BY donation_amount DESC) AS Rank
    FROM donor

--------------rank donors based on donation amount
    SELECT  donor_id,donor_name, donation_amount,
           ROW_NUMBER() OVER (ORDER BY donation_amount DESC) AS Rank
    FROM donor

----------- trigger that prevent anyone from inserting 
------------a new record in the charity_organization table

CREATE TRIGGER ss
ON charity_organization
instead of insert
as
select 'you can’t insert a new record in that table '
  
insert into charity_organization (id) values (20)

---for droping trigger
drop TRIGGER ss

----------------------trigger that prevent anyone from inserting 
----------------------a new record in the project table
CREATE TRIGGER pr
ON project
instead of insert
as
select 'you can’t insert a new record in that table '
  
insert into project (p_id) values (20)

---for droping trigger
drop TRIGGER pr





--create view that  display the total donations of all donors in the each branch.
create view total_donation_per_branch1 as
select id,charity_name , sum(donation_amount) Total_donation FROM charity_organization ch inner join donor d
on ch.id=d.org_id
group by id,charity_name

select * from total_donation_per_branch1

--create view that display number of projects per barnch 
create view projects_for_branchs 
as
select charity_name, count(p_id) total
from charity_organization ch inner join project p
on ch.id=p.org_id
group by charity_name

select * from projects_for_branchs 

----view that display count of volunteers for each project
create view volunteers_for_project 
as
select  p_name ,count( vol_id ) as total_volunteers
from project p inner join charity_organization ch on p.org_id = ch. id inner join volunteers v
on ch.id=v.org_id
group by p_name

select * from volunteers_for_project 



---create view that display  manager name for each branch .
create view manager_name_per_branch as
select charity_name , emp_name as manager 
from charity_organization ch inner join employee e
on manager_id=e.emp_id

select * from manager_name_per_branch

--create view that didplay average salary of employees for each branch
create view average_salary_per_branch as
SELECT ch.charity_name , AVG(e.salary) AS AverageSalary
FROM   charity_organization  ch inner join  employee e 
ON ch.id=e.org_id
GROUP BY ch.charity_name

select * from average_salary_per_branch

--Create a view that displays the names and salaries of employees 
--who earn more than the average salary 
create view employee_salaries_more_than_avg as
select ch.charity_name, e.emp_name,e.salary
from charity_organization  ch inner join  employee e 
ON ch.id=e.org_id
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employee
)

select * from employee_salaries_more_than_avg







