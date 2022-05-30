FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y vim git gcc g++ make python3-dev python3-pip python3-venv libxml2-dev libxslt1-dev zlib1g-dev gettext curl supervisor

RUN apt-get install -y sudo && \
    groupadd -g 1000 ubuntu && \
    useradd  -g      ubuntu -G sudo -m -s /bin/bash ubuntu && \
    echo 'ubuntu:ubuntu' | chpasswd && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt-get install -y nginx
COPY conf/nginx.conf /etc/nginx/sites-enabled/default

COPY conf/site.conf /etc/supervisor/conf.d/site.conf
COPY conf/bridged.conf /etc/supervisor/conf.d/bridged.conf
COPY conf/celery.conf /etc/supervisor/conf.d/celery.conf
COPY conf/wsevent.conf /etc/supervisor/conf.d/wsevent.conf


USER ubuntu

RUN sudo apt-get install -y nodejs npm && \
    sudo npm install -g sass postcss-cli postcss autoprefixer

RUN sudo apt-get install -y libmysqlclient-dev mysql-client

WORKDIR /home/ubuntu
# RUN git clone -b setup --depth 1 --recursive https://github.com/goropikari/online-judge site
COPY ./online-judge site
RUN sudo chown -R ubuntu:ubuntu site

RUN cd /home/ubuntu && \
    python3 -m venv site

WORKDIR /home/ubuntu/site
RUN . bin/activate && \
    pip install -r requirements.txt && \
    pip install mysqlclient django-redis

COPY conf/config.js websocket/config.js
RUN . bin/activate && \
    npm install qu ws simplesets && \
    pip install websocket-client

RUN . bin/activate && \
    sudo mkdir -p /var/www/static && \
    sudo chown -R ubuntu:www-data /var/www/static && \
    ./make_style.sh && \
    python manage.py collectstatic && \
    python3 manage.py compilemessages --locale en && \
    python3 manage.py compilemessages --locale ja && \
    python3 manage.py compilejsi18n --locale en && \
    python3 manage.py compilejsi18n --locale ja

RUN . bin/activate && \
    pip install wheel && \
    pip install uwsgi && \
    mkdir conf
COPY conf/uwsgi.ini conf/uwsgi.ini

RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh .
CMD bash entrypoint.sh
