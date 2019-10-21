select 
	Name as 'Product', 
	Description as 'Product Description',
	ListPrice as 'Retail Price', 
	Rating as 'Rating Out of 5', 
	Comments as 'Review', 
	ReviewerName as 'Reviewed By' 
from production.product price_name 
	inner join production.ProductModelProductDescriptionCulture desc_id
	on price_name.ProductModelID = desc_id.ProductModelID

	inner join Production.ProductDescription des
	on desc_id.ProductDescriptionID = des.ProductDescriptionID

	inner join production.ProductReview review_info
	on price_name.ProductID = review_info.ProductID
where cultureID = 'en'


