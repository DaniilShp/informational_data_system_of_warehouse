select idseller, seller.name, sum(product_cost * product_amount) as total, YEAR(date) AS _date
from invoice join supply using(idinvoice) JOin seller USING (idseller)
WHERE YEAR(invoice.date)=$input1
group by idseller, name, _date;