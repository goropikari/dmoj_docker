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

USER ubuntu

# update nodejs
RUN sudo apt-get install -y nodejs npm && \
    sudo npm install n -g && \
    sudo n stable && \
    sudo apt purge -y nodejs npm && \
    sudo npm install -g sass postcss-cli postcss autoprefixer

RUN sudo apt-get install -y libmysqlclient-dev mysql-client

WORKDIR /home/ubuntu
RUN git clone -b setup --depth 1 --recursive https://github.com/goropikari/online-judge site
# COPY ./online-judge site
RUN sudo chown -R ubuntu:www-data site

RUN cd /home/ubuntu && \
    python3 -m venv site

WORKDIR /home/ubuntu/site
RUN . bin/activate && \
    pip install -r requirements.txt && \
    pip install mysqlclient django-redis

RUN . bin/activate && \
    npm install qu ws simplesets && \
    pip install websocket-client

RUN . bin/activate && \
    pip install wheel && \
    pip install uwsgi && \
    mkdir conf

RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/sites-enabled/default
COPY conf/supervisord /etc/supervisor/conf.d/template
COPY conf/config.js websocket/config.js
COPY conf/uwsgi.ini conf/uwsgi.ini

ADD entrypoint.sh .
CMD bash entrypoint.sh
