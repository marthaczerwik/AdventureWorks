use AdventureWorks2012
go

select p.BusinessEntityID, p.FirstName, p.LastName, s.SalesYTD
from Person.Person p
inner join
(
	select BusinessEntityID, SalesYTD
	from Sales.SalesPerson
) s
on(p.BusinessEntityID = s.BusinessEntityID)
order by s.SalesYTD