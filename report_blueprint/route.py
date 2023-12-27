from flask import Blueprint, render_template, request, current_app, redirect, url_for, session
from work_with_db import select_dict, call_procedure
import os
from sql_provider import SQLProvider
from datetime import datetime
from authentication_blueprint.access import login_required, group_required
import ast

blueprint_report = Blueprint('bp_report', __name__, template_folder='templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))

@blueprint_report.route('/', methods=['GET', 'POST'])
@group_required
def reports_menu():
    if request.method == 'GET':
        return render_template('reports_menu.html')
    else:
        reports_dict = {'1': {'title': 'Отчет о стоимости поставок', 'procedure': 'update_activities',
                              'item_1': 'idseller', 'item_2': 'name', 'item_3': 'invoice_amount', 'item_4': 'average_cost',
                              'item_5': 'total_sum', 'item_6': 'mounth_activity', 'item_7': 'year_activity',
                              'name_1': 'id поставщика', 'name_2': 'поставщик', 'name_3': 'количество накладных', 'name_4': 'средняя цена товара',
                              'name_5': 'общая сумма', 'name_6': 'месяц', 'name_7': 'год',
                              'input1': 'Введите год', 'input2': 'Введите месяц', 'input1_type': 'int', 'input2_type': 'int',
                              'sql_query_name': 'find_report_activities.sql', 'find_dates_query': 'find_dates_activities.sql'},
                        '2': {'title': 'Отчет о количестве поставок на склад', 'procedure': 'update_supply',
                              'item_1': 'id_product', 'item_2': 'shifr', 'item_3': 'idseller', 'item_4': 'name', 'item_5': 'product_cost', 'item_6': 'product_amount', 'item_7': 'mounth_supply', 'item_8': 'year_supply',
                              'name_1': 'id продукта', 'name_2': 'продукт', 'name_3': 'id поставщика', 'name_4': 'поставщик', 'name_5': 'цена', 'name_6': 'количество', 'name_7': 'месяц', 'name_8': 'год',
                              'input1': 'Введите год', 'input1_type': 'int', 'input2': 'Введите месяц', 'input2_type': 'int',
                              'sql_query_name': 'find_report_accounting.sql', 'find_dates_query': 'find_dates_accounting.sql'}}
        users_choice = request.form.get('user_choice')
        print(users_choice, reports_dict[users_choice])
        session['reports_dict'] = reports_dict[users_choice]
        return redirect(url_for('bp_report.report_info'))

@blueprint_report.route('/report_info', methods=['GET', 'POST'])
@group_required
def report_info():
    if request.method == 'GET':
        return render_template('report_info.html', report_info=session['reports_dict'])
    else:
        users_choice = request.form.get('user_choice')
        if users_choice == 'create':
            return redirect(url_for('bp_report.create_report'))
        if users_choice == 'find':
            return redirect(url_for('bp_report.find_reports'))
        else:
            return "UNKNOWN_REPORT_TYPE"

@blueprint_report.route('/create_report', methods=['GET', 'POST'])
@group_required
def create_report():
    if request.method == 'GET':
        return render_template('create_report_input.html', report_info=session['reports_dict'])
    else:
        input1 = request.form.get('input1')
        input2 = request.form.get('input2')
        try:
            if session['reports_dict']['input1_type'] == 'int':
                input1 = int(input1)
            if session['reports_dict']['input2'] is not None:
                if session['reports_dict']['input2_type'] == 'int':
                    input2 = int(input2)
            if session['reports_dict']['input1_type'] == 'date':
                input1 = datetime.strptime(input1, '%Y-%m-%d')
        except ValueError:
            return render_template('create_report_input.html', error='некорректный ввод',
                                   report_info=session['reports_dict'])
        _sql = provider.get(session['reports_dict']['sql_query_name'],
                            input1=input1, input2=input2, table=session['reports_dict']['procedure'])
        res = select_dict(current_app.config['db_config'], _sql)
        print(res)
        if res is not None:
            sub_title = 'Данный отчет уже существовал'
            return render_template('create_report_dynamic.html',
                                   result=res, report_info=session['reports_dict'], sub_title=sub_title)
        else:
            cost = call_procedure(current_app.config['db_config'], session['reports_dict']['procedure'], input1, input2)
            _sql = provider.get(session['reports_dict']['sql_query_name'],
                                input1=input1, input2=input2, table=session['reports_dict']['procedure'])
            res = select_dict(current_app.config['db_config'], _sql)
            #prod_title = "Отчет успешно создан"
            if cost is None or res is None:
                return render_template('create_report_input.html',
                                       error='данные за указанный период не найдены',
                                       report_info=session['reports_dict'])
            else:
                print(res)
                print(session['reports_dict'])
                return render_template('create_report_dynamic.html', result=res, report_info=session['reports_dict'])


@blueprint_report.route('/find_reports', methods=['GET', 'POST'])
@group_required
def find_reports():
    if request.method == 'GET':
        _sql = provider.get(session['reports_dict']['find_dates_query'], table=session['reports_dict']['procedure'])
        res = select_dict(current_app.config['db_config'], _sql)
        if res is not None:
            title = 'существующие отчеты'
            print(res)
            return render_template('existing_reports.html', result=res,
                                   report_info=session['reports_dict'], title=title)
        else:
            return render_template('existing_reports.html', title='Отчеты еще не созданы',
                                   report_info=session['reports_dict'])
    else:
        users_choice_str = request.form.get('user_choice')
        input1, input2 = None, None
        try:
            users_choice = ast.literal_eval(users_choice_str)
            input1, input2 = users_choice.values()
        except:
            ValueError()
            input1 = users_choice_str
            input2 = None

        print(input1, input2)
        info = f"{input2} месяц {input1} года"
        _sql = provider.get(session['reports_dict']['sql_query_name'],
                            input1=input1, input2=input2, table=session['reports_dict']['procedure'])
        res = select_dict(current_app.config['db_config'], _sql)
        return render_template('create_report_dynamic.html',
                               result=res, report_info=session['reports_dict'], info=info)

