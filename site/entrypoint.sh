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

python3 manage.py runbridged &
python3 manage.py runserver 0.0.0.0:8000
