--select distinct [Major Names] from Engage_Data where [Major Names] like '%n/a%'
--select * from Engage_Data where [Major Names] like '%Bio%'
DECLARE @mnl MajorNamesListType
INSERT into @mnl VALUES (''),(' '),('Engineering-Undeclared')--,('Construction Engineering and Management'),('Construction Engr and Mgmt'),('Construction Management'),('MS Construction Engineering and Management')--,('Master Civil Engineering')--,('computer science + linguistics'),('"Economics,Computer Science"'),('Computer Science')


--,('')

DECLARE @dispMajorName as varchar(100)
SET @dispMajorName = 'Blank'

EXECUTE sp_main_analysis @mnl, @dispMajorName

select * from Analysis_Week2

-- select top(50) * from Engage_Data where "Opened" = 'Y'
-- 
-- select * from Analysis_Week2

--drop procedure [sp_main_analysis]

--delete from Analysis_Week2

--select * from Engage_Data where "Major Names" like ('"'+'Computer Science%')


-- select * from Engage_Data where [Major Names] in (('"Economics,Mechanical Engineering"'),('"Mechanical Engineering,Computer Science"'),('"Physics,Mechanical Engineering"'),('"Performance,Mechanical Engineering"'),('"Mechanical Engineering,Campus Certificate Program'),('Mechanical Engineering'),('"Spanish,Mechanical Engineering"')) and "Opened" = 'Y'

--delete from Analysis_Week2 where [Major] = 'na'

--select * from Engage_data where [Major Names] = 'Campus Certificate Program'
