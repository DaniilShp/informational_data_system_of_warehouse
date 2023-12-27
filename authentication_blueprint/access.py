from functools import wraps
from flask import session, current_app, request, Blueprint, redirect, url_for, render_template
from work_with_db import select_dict
from sql_provider import SQLProvider
import os

authentication_blueprint = Blueprint('auth_bp', __name__, template_folder = 'templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), '../../transport_company/authentication_blueprint/sql'))


def login_required(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        if 'user_id' in session:
            return func(*args, **kwargs)
        return redirect(url_for('auth_bp.auth_index'))
    return wrapper

def group_required(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        if 'user_id' in session:
            user_group = session.get('user_group')
            if user_group:
                access = current_app.config['access_config'] #глобальная переменная
                user_target = request.blueprint
                if user_group in access and user_target in access[user_group]:
                    return func(*args, **kwargs)
                else:
                    if 'seller' in session['user_group']:
                        return redirect(url_for('business_bp.menu_index'))
                    return render_template('not_avaliable.html')
            else:
                return 'Только для внутренних пользователей'
        else:
            #return 'Вам необходимо авторизоваться!'
            session['previous_url'] = request.referrer
            return redirect(url_for('auth_bp.auth_index'))
    return wrapper

def internal_menu_required(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        if 'user_group' in session:
            if 'seller' in session['user_group']:
                return redirect(url_for('business_bp.menu_index'))
            else:
                return func(*args, **kwargs)
        else:
            return redirect(url_for('auth_bp.auth_index'))
    return wrapper

@authentication_blueprint.route('/', methods = ['GET', 'POST'])
def auth_index():
    if request.method == 'GET':
        return render_template("auth_form.html")
    else:
        login = request.form.get('login')
        password = request.form.get('password')
        if not login or not password:
            return render_template("auth_form.html", error_message = 'пустое поле')
        else:
            _sql = provider.get('search_in_internal_users.sql', usr_login=login, usr_password=password)
            users = select_dict(current_app.config['db_config'], _sql)
            if users is None:
                _sql = provider.get('search_in_external_users.sql', usr_login=login, usr_password=password)
                users = select_dict(current_app.config['db_config'], _sql)
                if users is not None:
                    users[0].update({'user_group': 'seller'})
            if users is not None:
                print(users)
                print(users[0]['userid'])
                session['user_id'] = users[0]['userid']
                session['user_group'] = users[0]['user_group']
                if users[0]['user_group'] == 'seller':
                    return redirect(url_for('business_bp.menu_index'))
                else:
                    return redirect(url_for('main_menu'))
            else:
                return render_template("auth_form.html", error_message='неверный логин/пароль')

@authentication_blueprint.route('/lk', methods = ['GET', 'POST'])
@login_required
def lk_index():
    user_group = session.get('user_group')
    return render_template('lk.html', user_group=user_group)