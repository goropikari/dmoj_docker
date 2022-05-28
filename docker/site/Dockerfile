FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y vim git gcc g++ make python3-dev python3-pip python3-venv libxml2-dev libxslt1-dev zlib1g-dev gettext curl

RUN apt-get install -y sudo && \
    groupadd -g 1000 ubuntu && \
    useradd  -g      ubuntu -G sudo -m -s /bin/bash ubuntu && \
    echo 'ubuntu:ubuntu' | chpasswd && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu

RUN sudo apt-get install -y nodejs npm && \
    sudo npm install -g sass postcss-cli postcss autoprefixer

RUN sudo apt-get install -y libmysqlclient-dev mysql-client

WORKDIR /home/ubuntu
RUN git clone -b setup --depth 1 --recursive https://github.com/goropikari/online-judge site

WORKDIR /home/ubuntu/site
RUN pip3 install -r requirements.txt && \
    pip3 install mysqlclient django-redis

RUN ./make_style.sh && \
    python3 manage.py collectstatic && \
    python3 manage.py compilemessages && \
    python3 manage.py compilejsi18n

RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh .
CMD bash entrypoint.sh
