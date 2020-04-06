-- -------------------------------
-- Challenge 1
-- -------------------------------

with 
sales_royalty as (
	select  
		ta.au_id												as Author,
		t.title_id  											as Titles,
		IFNULL(t.advance, 0) 									as Advance,
		(IFNULL(t.price,0)*IFNULL(s.qty,0)*IFNULL(t.royalty,0)*ta.royaltyper/10000)				
		as SalesRoyalty
	from titles t
	inner join titleauthor ta
		on t.title_id = ta.title_id
	left join sales s
		on t.title_id = s.title_id 
),

combined_for_books_and_authors as(
	select 
		Author,
		Titles,
		sum(SalesRoyalty)	as TotalRoyaltyForBook,
		sum(Advance)/count(*)	as Advance
	from sales_royalty
	group by 1,2
),

profiting_authors as (
	Select 
		Author,
		sum(TotalRoyaltyForBook)+Sum(Advance) 	as TotalSales
	from combined_for_books_and_authors cba
	group by Author
	order by TotalSales desc
)


select 
	Author,
	a.au_fname				as FirstName,
	a.au_lname				as LastName,
	TotalSales
from profiting_authors pa
Inner Join pubs.authors a
	on Author = a.au_id
;


-- --------------------------------
-- Approach 2, using derived Tables
-- --------------------------------

select 
	Author,
	a.au_fname				as FirstName,
	a.au_lname				as LastName,
	TotalSales
from 
	(
	Select 
		Author,
		sum(TotalRoyaltyForBook)+Sum(Advance) 	as TotalSales
	from
		(
		select 
			Author,
			Titles,
			sum(SalesRoyalty)	as TotalRoyaltyForBook,
			sum(Advance)/count(*)	as Advance
		from  
			(
			select  
				ta.au_id																	as Author,
				t.title_id  																as Titles,
				IFNULL(t.advance, 0) 														as Advance,
				(IFNULL(t.price,0)*IFNULL(s.qty,0)*IFNULL(t.royalty,0)*ta.royaltyper/10000)	as SalesRoyalty
			from titles t
			inner join titleauthor ta
				on t.title_id = ta.title_id
			left join sales s
				on t.title_id = s.title_id 
			) sales_royalty
		group by 1,2
		) combined_for_books_and_authors
	group by Author
	order by TotalSales desc
	) profiting_authors
Inner Join pubs.authors a
	on Author = a.au_id
	limit 3
; 
