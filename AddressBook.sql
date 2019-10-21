USE AdventureWorks2012
GO

SELECT  
	Name AS 'Department', 
	FirstName AS 'First Name', 
	LastName  AS 'Last Name', 
	EmailAddress AS 'Email', 
	PhoneNumber as 'Phone No.'
FROM Person.person pers

INNER JOIN HumanResources.EmployeeDepartmentHistory depthistory
ON pers.BusinessEntityID = depthistory.BusinessEntityID

INNER JOIN HumanResources.Department dept
ON depthistory.DepartmentID = dept.DepartmentID

INNER JOIN Person.PersonPhone phone
ON pers.BusinessEntityID = phone.BusinessEntityID

INNER JOIN Person.EmailAddress email
ON phone.BusinessEntityID = email.BusinessEntityID

ORDER BY Name


