from flask_app import app
from flask import request
import pymysql
import pandas as pd


@app.route('/process', methods=['POST'])
def process():
    data = request.get_json()
    hostname = "tagoosedatabase.cgqt2xgtwhsd.us-east-2.rds.amazonaws.com"
    dbname = "TagooseDatabase"
    user="justintjoa"
    password="fOrtranmyeggo124"

    conn = pymysql.connect(host=hostname, user=user, port=3306, passwd=password, db=dbname)

    pd.read_sql('SELECT *FROM ALL_OUT', con=conn)
    return data

    #anth phil pol