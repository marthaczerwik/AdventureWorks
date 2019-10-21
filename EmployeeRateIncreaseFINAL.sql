USE AdventureWorks2012
GO

select minTable.BusinessEntityID, person.FirstName, person.LastName, em.JobTitle, 
convert(varchar, min(minTable.RateChangeDate), 23) as 'MinDate', RIGHT('$'+ CONVERT(VARCHAR,min(minTable.Rate)),7) as 'Min Rate', 
convert(varchar, originalTable.RateChangeDate, 23) as 'MaxDate', RIGHT('$'+ CONVERT(VARCHAR,originalTable.Rate),7) as 'MaxRate',
 (100 * (originalTable.Rate - min(minTable.Rate)))/min(minTable.Rate) as 'Increase'

from HumanResources.EmployeePayHistory minTable
inner join
(
select BusinessEntityID, max(RateChangeDate) as 'MaxDate', max(Rate) as 'Max Rate'
from HumanResources.EmployeePayHistory
group by BusinessEntityID
) as maxTable
on (minTable.BusinessEntityID = maxTable.BusinessEntityID)

inner join Person.Person person
	on minTable.BusinessEntityID = person.BusinessEntityID

inner join HumanResources.Employee em
	on minTable.BusinessEntityID = em.BusinessEntityID

inner join
(
select *
from HumanResources.EmployeePayHistory
) as originalTable
on (maxTable.BusinessEntityID = originalTable.BusinessEntityID)
where originalTable.RateChangeDate = maxTable.MaxDate
group by minTable.BusinessEntityID, person.FirstName, person.LastName, em.JobTitle, originalTable.RateChangeDate, originalTable.Rate
order by  (100 * (originalTable.Rate - min(minTable.Rate)))/min(minTable.Rate) DESC
