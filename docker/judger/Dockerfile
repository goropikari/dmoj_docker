FROM dmoj/runtimes-tier3:latest

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git

# install AtCoder library
RUN cd /usr/include && \
    git clone https://github.com/atcoder/ac-library && \
    mv ac-library/atcoder .

# RUN pip3 install dmoj  # maybe executor is old
# COPY ./judge-server ./judge-server
RUN cd ~ && git clone --depth 1 --recursive https://github.com/goropikari/judge-server.git
RUN cd ~/judge-server && \
    pip3 install -r requirements.txt && \
    python3 setup.py install

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

USER judge
ARG SITE_HOST web

# wait until site server is active.
ENTRYPOINT sleep 20 && dmoj -c ~/problems/judge.yml ${SITE_HOST}
