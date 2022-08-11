#!/bin/bash

until mysqladmin ping -h $DB_HOST -u$DB_USER -p$DB_PASSWORD --silent; do
  echo 'waiting for mysqld to be connectable...'
  sleep 2
done

# mysql -h db -uroot -proot
# DROP DATABASE IF EXISTS dmoj;
# CREATE DATABASE dmoj DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;
# GRANT ALL PRIVILEGES ON dmoj.* to 'dmoj'@'%' IDENTIFIED BY 'password';
# exit


. bin/activate

if [ ! -e /var/www/static ]; then
    sudo mkdir -p /var/www/static
    sudo chown -R ubuntu:www-data /var/www/static
    ./make_style.sh
    python manage.py collectstatic
    python3 manage.py compilemessages --locale en
    python3 manage.py compilemessages --locale ja
    python3 manage.py compilejsi18n --locale en
    python3 manage.py compilejsi18n --locale ja

    python3 manage.py migrate
    python3 manage.py loaddata navbar
    python3 manage.py loaddata language_all
    python3 manage.py loaddata demo
fi

# for communication with judge server
# python3 manage.py runbridged &

# Even if there is no celery setting, judge works correctly.
# So I don't know whether celery is needed or not.
# export PATH=$PATH:$HOME/.local/bin
# celery -A dmoj_celery worker &

# uwsgi --ini conf/uwsgi.ini &

# /usr/bin/node websocket/daemon.js &

for conf in bridged.conf site.conf celery.conf wsevent.conf
do
    sudo -E envsubst < /etc/supervisor/conf.d/template/${conf} | sudo tee /etc/supervisor/conf.d/${conf}
done

sudo service nginx start
sudo supervisord -c /etc/supervisor/supervisord.conf

# DEBUG=true python3 manage.py runserver 0.0.0.0:8000
sleep infinity
