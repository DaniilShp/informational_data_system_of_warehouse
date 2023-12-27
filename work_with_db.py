from DBcm import DBContextManager
from datetime import datetime

def select_dict(db_config: dict, _sql: str):
    with DBContextManager(db_config) as cursor:
        if cursor is None:
            raise ValueError('Курсор не создан')
        else:
            cursor.execute(_sql)
            products = cursor.fetchall()
            if products:
                schema = [item[0] for item in cursor.description]
                products_dict = []
                for product in products:
                    products_dict.append(dict(zip(schema, product)))
                return products_dict
            else:
                return None

def call_procedure(dbconfig: dict, proc_name: str, *args):
    with DBContextManager(dbconfig) as cursor:
        if cursor is None:
            raise ValueError('Курсор не создан')
        param_list = []
        for arg in args:
            param_list.append(arg)
        result = cursor.callproc(proc_name, param_list)
        return result

def save_invoice_with_list(config, user_id, total_sum, current_invoice, provider, sql_save_invoice, sql_fill_in_supply):
    with DBContextManager(config) as cursor:
        if cursor is None:
            raise ValueError('Курсор не найден')
        else:
            now = datetime.now()
            sql_date = now.strftime("%Y-%m-%d")
            #sql_save_invoice = f"insert into invoice (total_sum, idseller, date) values (sum, 1, '2020-10-22')"
            sql_query = provider.get(sql_save_invoice, total_sum=total_sum, id=user_id, date=sql_date)
            cursor.execute(sql_query)
            latest_invoice_id = cursor.lastrowid
            if latest_invoice_id:
                for key in current_invoice.keys():
                    for item in current_invoice[key]:
                        #sql_fill_in_supply = f"insert into supply (product_cost, product_amount, idinvoice, idproduct) values ({current_invoice[key]['price']}, {current_invoice[key]['amount']}, {latest_invoice_id}, {key})"
                        sql_query = provider.get(sql_fill_in_supply, cost=item['price'],
                        amount=item['amount'], id_invoice=latest_invoice_id, id_product=key)
                        cursor.execute(sql_query)