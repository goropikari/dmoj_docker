#!/bin/bash

# adhoc db wait
sleep 15

# mysql -h db -uroot -proot
# DROP DATABASE IF EXISTS dmoj;
# CREATE DATABASE dmoj DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;
# GRANT ALL PRIVILEGES ON dmoj.* to 'dmoj'@'%' IDENTIFIED BY 'password';
# exit

. ./bin/activate

python3 manage.py migrate
python3 manage.py loaddata navbar
# python3 manage.py loaddata languages
python3 manage.py loaddata language_all
python3 manage.py loaddata demo

# for communication with judge server
# python3 manage.py runbridged &

# Even if there is no celery setting, judge works correctly.
# So I don't know whether celery is needed or not.
# export PATH=$PATH:$HOME/.local/bin
# celery -A dmoj_celery worker &

# uwsgi --ini conf/uwsgi.ini &

# /usr/bin/node websocket/daemon.js &

for conf in bridged.conf site.conf celery.conf
do
    sudo sed -i -e "s/__DB_DATABASE__/${DB_DATABASE}/" /etc/supervisor/conf.d/${conf}
    sudo sed -i -e "s/__DB_HOST__/${DB_HOST}/" /etc/supervisor/conf.d/${conf}
    sudo sed -i -e "s/__DB_USER__/${DB_USER}/" /etc/supervisor/conf.d/${conf}
    sudo sed -i -e "s/__DB_PASSWORD__/${DB_PASSWORD}/" /etc/supervisor/conf.d/${conf}
    sudo sed -i -e "s/__DEBUG__/${DEBUG}/" /etc/supervisor/conf.d/${conf}
    sudo sed -i -e "s/__TWO_STEP_REGISTRATION__/${TWO_STEP_REGISTRATION}/" /etc/supervisor/conf.d/${conf}
done

sudo service nginx start
sudo supervisord

# DEBUG=true ython3 manage.py runserver 0.0.0.0:8000
sleep infinity
