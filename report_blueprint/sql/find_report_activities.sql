select idseller, name, invoice_amount, average_cost, total_sum, mounth_activity, year_activity
from update_activities JOIN seller using(idseller)
where year_activity = $input1 and mounth_activity = $input2