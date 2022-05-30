FROM dmoj/runtimes-tier3:latest

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git

RUN mkdir -p /problems
COPY ./problems/judge.yml /problems

RUN git clone --depth 1 https://github.com/goropikari/docs /problems/docs && \
    cd /problems && \
    cp -r docs/problem_examples/standard/aplusb/ .

# RUN pip3 install dmoj  # maybe executor is old
RUN git clone --depth 1 --recursive https://github.com/goropikari/judge-server.git
# COPY ./judge-server ./judge-server
RUN cd judge-server && \
    pip3 install -r requirements.txt && \
    python3 setup.py develop

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cd /usr/include && \
    git clone https://github.com/atcoder/ac-library && \
    mv ac-library/atcoder .

USER judge
ARG SITE_HOST web

# wait until site server is active.
ENTRYPOINT sleep 30 && dmoj -c /problems/judge.yml ${SITE_HOST}
