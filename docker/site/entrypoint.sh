#!/bin/bash

# adhoc db wait
sleep 15

# mysql -h db -uroot -proot
# DROP DATABASE IF EXISTS dmoj;
# CREATE DATABASE dmoj DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;
# GRANT ALL PRIVILEGES ON dmoj.* to 'dmoj'@'%' IDENTIFIED BY 'password';
# exit

python3 manage.py migrate
python3 manage.py loaddata navbar
python3 manage.py loaddata languages
python3 manage.py loaddata demo

# for communication with judge server
python3 manage.py runbridged &

# Even if there is no celery setting, judge works correctlyc.
# So I don't know whether celery is needed or not.
export PATH=$PATH:$HOME/.local/bin
celery -A dmoj_celery worker &

uwsgi --ini conf/uwsgi.ini &

sudo service nginx start

# python3 manage.py runserver 0.0.0.0:8000
sleep infinity
