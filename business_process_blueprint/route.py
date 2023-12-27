from functools import wraps
from flask import session, current_app, request, Blueprint, redirect, url_for, render_template
from work_with_db import select_dict
from authentication_blueprint.access import login_required, group_required
import os
from sql_provider import SQLProvider
from work_with_db import save_invoice_with_list


business_process_blueprint = Blueprint('business_bp', __name__, template_folder='templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))

@business_process_blueprint.route('/menu', methods = ['GET'])
@login_required
def menu_index():
    return render_template('external_user_menu.html')

@business_process_blueprint.route('/register_invoice', methods = ['GET', 'POST'])
@group_required
def register_invoice_index():
    if request.method == 'GET':
        _sql = provider.get('items_for_invoice.sql', id=session['user_id'])
        products = select_dict(current_app.config['db_config'], _sql)
        current_invoice = session.get('invoice', {})
        print(current_invoice)
        return render_template('create_invoice.html', items=products, invoice=current_invoice)
    else:
        product_id = request.form.get('idproduct')
        amount = request.form.get('amount')
        cost = request.form.get('cost')
        print(product_id, amount, cost, sep=' ')
        _sql = provider.get('find.sql', id=product_id)
        item = select_dict(current_app.config['db_config'], _sql)
        if amount != '' and cost != '':
            add_to_invoice(product_id, item[0], amount, cost)
        return redirect(url_for('business_bp.register_invoice_index'))

def add_to_invoice(prod_id, item, amount, cost):
    session.permanent = True
    if 'invoice' not in session:
        session['invoice'] = {}
    if prod_id not in session['invoice']:
        session['invoice'][prod_id] = [{'shifr': item['shifr'], 'price': cost, 'amount': int(amount),
                                       'measurerment_unit': item['measurerment_unit']}]
    else:
        flag = 0
        for i in range(len(session['invoice'][prod_id])):
            if int(session['invoice'][prod_id][i]['price']) == int(cost):
                session['invoice'][prod_id][i]['amount'] += int(amount)
                flag = 1
                break
        if flag == 0:
            session['invoice'][prod_id].append({'shifr': item['shifr'], 'price': cost, 'amount': int(amount),
                                           'measurerment_unit': item['measurerment_unit']})
    current_invoice = session.get('invoice', {})
    print(current_invoice)
    _sql = provider.get('items_for_invoice.sql', id=session['user_id'])
    products = select_dict(current_app.config['db_config'], _sql)
    return render_template('create_invoice.html', items=products, invoice=current_invoice)

@business_process_blueprint.route('/clear', methods=['GET'])
def clear_invoice():
    session['invoice'].clear()
    return redirect(url_for('business_bp.register_invoice_index'))

def count_invoice_sum(current_invoice):
    final_sum = 0
    for product in current_invoice.values():
        for item in product:
            final_sum += int(item['price']) * int(item['amount'])
    return final_sum

@business_process_blueprint.route('/order_created', methods=['GET'])
def save_invoice():
    user_id = session['user_id']
    current_invoice = session.get('invoice', {})
    if current_invoice is not None:
        print(current_invoice)
        total_sum = count_invoice_sum(current_invoice)
        save_invoice_with_list(current_app.config['db_config'], user_id, total_sum, current_invoice, provider,
                               'save_invoice.sql', 'fill_in_supply.sql')
        session.pop('invoice')
        return render_template('invoice_created.html', products=current_invoice, total=total_sum)
    #return "Заказ создан"