use adventureWorks2012
go

/** Distance=0 means that that point is the center of the circle **/
select	
		/** Data from the first table **/
		p.BusinessEntityID, p.PersonType, p.FirstName, p.LastName, 
		/** Data from the second table **/
		a.AddressID, a.AddressLine1, a.AddressLine2, a.City, a.StateProvinceID, a.PostalCode,
		/** Data from the last table **/
		distanceTable.Distance as 'Distance(km)'

from Person.Person p

inner join
(
	select *
	from Person.BusinessEntityAddress
) b
on(p.BusinessEntityID = b.BusinessEntityID)

inner join
(
	select *
	from Person.Address) a
on(b.AddressID = a.AddressID)

inner join
(
select	AddressID, AddressLine1,AddressLine2, City, StateProvinceID,
		cast(SpatialLocation as geography).Lat as 'Latitude',
		cast(SpatialLocation as geography).Long as 'Longitude',
		111000 *
		sqrt(
			power(
				abs(cast(SpatialLocation as geography).Long -
					(select	cast(SpatialLocation as geography).Long as 'Longitude'
					from Person.address
				where AddressID = '1'))
			, 2)

			+

			power(
				abs(cast(SpatialLocation as geography).Lat -
					(select	cast(SpatialLocation as geography).Lat as 'Latitude'
					from Person.address
				where AddressID = '1'))
			,2)
		)
		/ 1000
		as 'Distance'
from Person.address
		/**
		If you think the earth as the perfect sphere,
		the length of latitude and longitude for 1 degee are approximetly 111km
		**/

		/** 111km **/
where	111000 *
		sqrt(
			power(
				abs(cast(SpatialLocation as geography).Long -
					(select	cast(SpatialLocation as geography).Long as 'Longitude'
					from Person.address
				where AddressID = '1'))
			, 2)

			+

			power(
				abs(cast(SpatialLocation as geography).Lat -
					(select	cast(SpatialLocation as geography).Lat as 'Latitude'
					from Person.address
				where AddressID = '1'))
			,2)
		)

		/** 10km **/
		< 10 * 1000
) distanceTable
on(a.AddressID = distanceTable.AddressID)

/** The closest distance to the furthest distance **/
order by distanceTable.Distance