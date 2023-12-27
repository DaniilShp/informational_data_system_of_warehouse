import json
from blueprint_query.route import blueprint_query
from authentication_blueprint.access import authentication_blueprint
from report_blueprint.route import blueprint_report
from business_process_blueprint.route import business_process_blueprint
from flask import Flask, redirect, url_for, render_template, session
from authentication_blueprint.access import internal_menu_required, login_required

app = Flask(__name__)
with open('db_config.json') as f:
    app.config['db_config'] = json.load(f)
with open('authentication_blueprint/access.json') as f:
    app.config['access_config'] = json.load(f)

app.register_blueprint(blueprint_query, url_prefix = '/query')
app.register_blueprint(authentication_blueprint, url_prefix = '/auth')
app.register_blueprint(blueprint_report, url_prefix='/report')
app.register_blueprint(business_process_blueprint, url_prefix='/business_process')

app.secret_key = 'you will never guess'

@app.route('/')
@internal_menu_required
def main_menu():
    return render_template('main_menu.html')

@app.route('/exit')
def query_func():
    session.clear()
    return redirect(url_for('auth_bp.auth_index'))

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5001, debug=True)

