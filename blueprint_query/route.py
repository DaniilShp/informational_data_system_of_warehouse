import os
from flask import Blueprint, render_template, request, current_app, redirect, session, url_for
from work_with_db import select_dict
from sql_provider import SQLProvider
from authentication_blueprint.access import login_required, group_required

blueprint_query = Blueprint('bp_query', __name__, template_folder = 'templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))
print(os.path.dirname(__file__))
print(os.path.join(os.path.dirname(__file__), 'sql'))

@blueprint_query.route('/query_menu', methods = ['GET'])
@login_required
def start_index():
    return render_template("main_menu_zaproses.html")

@blueprint_query.route('/sellers_info', methods = ['GET', 'POST'])
@group_required
def query1_index():
    names = {'title': 'Показать все сведения о поставщиках, заключивших договора в заданную дату',
             'item1': 'год', 'item2': 'месяц'}
    items = {'item1': 'name', 'item2': 'location', 'item3': 'bank', 'item4': 'telephone_number'}
    if request.method == 'GET':
        return render_template('input_param.html', **names)
    else:
        year = request.form.get('category1')
        mounth = request.form.get('category2')
        if not year or not mounth:
            return render_template('input_param.html', **names,  error_message = 'пустое поле')
        if not year or not mounth:
            return render_template('input_param.html', **names, error_message='пустое поле')
        if not year.isdigit() or not mounth.isdigit():
            return render_template('input_param.html', **names, error_message="некорректное значение года или месяца")
        _sql = provider.get('seller_info.sql', year = year, mounth = mounth)
        result = select_dict(current_app.config['db_config'], _sql)
        print(result)
        if result:
            prod_title = names['title'] + f': {mounth} месяц {year} года'
            return render_template('dynamic.html', **items, result=result,
                                    prod_title=prod_title)
        else:
            return redirect('/query/error')

@blueprint_query.route('/signing_date', methods = ['GET', 'POST'])
@group_required
def query2_index():
    names = {'title': 'Показать все сведения о поставщиках, заключивших договора в заданный период',
             'item1': 'не ранее дней назад:', 'item2': 'не позднее дней назад:'}
    items = {'item1': 'name', 'item2': 'location', 'item3': 'bank', 'item4': 'contract_signing'}
    if request.method == 'GET':
        return render_template('input_param.html', **names)
    else:
        days_amount1 = request.form.get('category1')
        days_amount2 = request.form.get('category2')
        if not days_amount1 or not days_amount2:
            return render_template('input_param.html', **names, error_message='пустое поле')
        if not days_amount1.isdigit() or not days_amount2.isdigit():
            return render_template('input_param.html', **names, error_message="некорректное значение количества дней")

        _sql = provider.get('signing_date.sql', days1=days_amount1, days2=days_amount2)
        result = select_dict(current_app.config['db_config'], _sql)
        print(result)
        if result:
            prod_title = names['title'] + ': ' + f'от {days_amount1} до {days_amount2} дней назад'
            return render_template('dynamic.html', **items, result=result,
                                   prod_title=prod_title)
        else:
            return redirect('/query/error')

@blueprint_query.route('/tel_numbers', methods = ['GET', 'POST'])
@group_required
def query3_index():
    items = {'title': 'Показать всех поставщиков, у которых номера тел. имеют некоторый префикс',
             'item1': 'name', 'item2': 'telephone_number'}
    names = {'item1': 'префикс:'}
    if request.method == 'GET':
        return render_template('input_param.html', **names, title=items['title'])
    else:
        prefix = request.form.get('category1')
        if not prefix:
            return render_template('input_param.html', **names, error_message='пустое поле')
        if not prefix.isdigit():
            return render_template('input_param.html', **names, error_message="некорректное значение")
        _sql = provider.get('tel_numbers.sql', prefix=prefix)
        print(_sql)
        result = select_dict(current_app.config['db_config'], _sql)
        print(result)
        if result:
            prod_title = items['title'] + ': ' + prefix
            return render_template('dynamic.html', **items,
                                   result=result, prod_title=prod_title)
        else:
            return redirect('/query/error')

@blueprint_query.route('/unactive_sellers', methods = ['GET'])
@group_required
def query4_index():
    items = {'title': 'Показать поставщиков, заключивших договор, но не совершивших поставку',
             'item1': 'name', 'item2': 'contract_signing'}
    _sql = provider.get('unactive_sellers.sql')
    result = select_dict(current_app.config['db_config'], _sql)
    if result:
        prod_title = items['title']
        return render_template('dynamic.html', **items,
                               result=result, prod_title=prod_title)
    else:
        return redirect('/query/error')

@blueprint_query.route('/signing_date', methods = ['GET', 'POST'])
@group_required
def query5_index():
    names = {'title': 'Показать все сведения о количестве товаров на складе',
             'item1': 'не ранее дней назад:', 'item2': 'не позднее дней назад:'}
    items = {'item1': 'name', 'item2': 'location', 'item3': 'bank', 'item4': 'contract_signing'}
    if request.method == 'GET':
        return render_template('input_param.html', **names)
    else:
        days_amount1 = request.form.get('category1')
        days_amount2 = request.form.get('category2')
        if not days_amount1 or not days_amount2:
            return render_template('input_param.html', **names, error_message='пустое поле')
        if not days_amount1.isdigit() or not days_amount2.isdigit():
            return render_template('input_param.html', **names, error_message="некорректное значение количества дней")

        _sql = provider.get('signing_date.sql', days1=days_amount1, days2=days_amount2)
        result = select_dict(current_app.config['db_config'], _sql)
        print(result)
        if result:
            prod_title = names['title'] + ': ' + f'от {days_amount1} до {days_amount2} дней назад'
            return render_template('dynamic.html', **items, result=result,
                                   prod_title=prod_title)
        else:
            return redirect('/query/error')

@blueprint_query.route('/total_cost', methods = ['GET', 'POST'])
@group_required
def query6_index():
    names = {'title': 'Показать все сведения об общей стоимости товаров, поставленных каждым поставщиком',
             'item1': 'год:'}
    items = {'item1': 'idseller', 'item2': 'name', 'item3': 'total', 'item4': '_date'}
    if request.method == 'GET':
        return render_template('input_param.html', **names)
    else:
        input1 = request.form.get('category1')
        if not input1:
            return render_template('input_param.html', **names, error_message='пустое поле')
        if not input1.isdigit():
            return render_template('input_param.html', **names, error_message="некорректное значение количества дней")

        _sql = provider.get('total_cost.sql', input1=input1)
        result = select_dict(current_app.config['db_config'], _sql)
        print(result)
        if result:
            prod_title = names['title'] + ': ' + f'год - {input1}'
            return render_template('dynamic.html', **items, result=result,
                                   prod_title=prod_title)
        else:
            return redirect('/query/error')

@blueprint_query.route('/error', methods = ['GET', 'POST'])
def query_error_index():
    return render_template('error.html')

@blueprint_query.route('/exit', methods = ['GET', 'POST'])
def query_exit_index():
    session.clear()
    #session.pop('user_id') #удаление сессии конкретного пользователя
    #return "Вы вышли()"
    return redirect(url_for('auth_bp.auth_index'))