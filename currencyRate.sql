use AdventureWorks2012
go

select distinct cr.ToCurrencyCode, cr6.Name as 'Country Name', cr2.MinRate, cr3.MaxRate, (cr3.MaxRate - cr2.MinRate) as 'Gap', cr4.TotalAverageRate
from Sales.CurrencyRate cr

inner join
(
select ToCurrencyCode, min(EndOfDayRate) as 'MinRate'
from Sales.CurrencyRate
where	year(CurrencyRateDate) = 2005 and
		month(CurrencyRateDate) = 07
group by ToCurrencyCode
) as cr2
on (cr.ToCurrencyCode = cr2.ToCurrencyCode)

inner join
(
select ToCurrencyCode, max(EndOfDayRate) as 'MaxRate'
from Sales.CurrencyRate
where	year(CurrencyRateDate) = 2005 and
		month(CurrencyRateDate) = 07
group by ToCurrencyCode
) as cr3
on (cr2.ToCurrencyCode = cr3.ToCurrencyCode)

inner join
(
select ToCurrencyCode, avg(EndOfDayRate) as 'TotalAverageRate'
from Sales.CurrencyRate
where	year(CurrencyRateDate) = 2005 and
		month(CurrencyRateDate) = 07
group by ToCurrencyCode
) as cr4
on (cr3.ToCurrencyCode = cr4.ToCurrencyCode)

inner join
Sales.CountryRegionCurrency cr5
on (cr4.ToCurrencyCode = cr5.CurrencyCode)

inner join
Person.CountryRegion cr6
on (cr5.CountryRegionCode = cr6.CountryRegionCode)

order by cr4.TotalAverageRate