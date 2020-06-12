select top 5 * from demographic

select top 5 * from product

select top 5 * from transaction_data


select  *
from demographic a, product b, transaction_data c
where a.household_key=c.household_key
and c.PRODUCT_ID=b.PRODUCT_ID

select * from transaction_data where WEEK_NO=50

select distinct PRODUCT_ID from product
where PRODUCT_ID in (
						select distinct PRODUCT_ID
						from transaction_data
						where WEEK_NO=50)

select MAX(sales_value) as salesValue, PRODUCT_ID
from transaction_data a
where a.PRODUCT_ID in (
						select distinct PRODUCT_ID
						from product)
group by PRODUCT_ID
--having MAX(sales_value)>=99.99
order by 1 desc


select * from product
where PRODUCT_ID in (
						select distinct PRODUCT_ID
						from transaction_data
						where WEEK_NO=98
						)

select distinct WEEK_NO from transaction_data order by WEEK_NO desc --where WEEK_NO=98