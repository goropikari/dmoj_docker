FROM debian:stable-slim

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y libseccomp-dev git python3-pip

# Install runtime
RUN apt-get install -y \
    clang \
    g++ \
    gcc \
    gfortran \
    golang \
    nodejs \
    openjdk-17-jdk \
    pypy3 \
    racket \
    ruby

# RUN pip3 install dmoj
RUN git clone --depth 1 --recursive https://github.com/goropikari/judge-server.git && \
    cd judge-server && \
    pip3 install -r requirements.txt && \
    python3 setup.py develop

RUN mkdir -p /problems
COPY ./problems/judge.yml /problems

RUN git clone --depth 1 https://github.com/goropikari/docs /problems/docs && \
    cd /problems && \
    cp -r docs/problem_examples/standard/aplusb/ .

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd dmoj
USER dmoj
ARG SITE_HOST web

# wait until site server is active.
CMD sleep 30 && dmoj -c /problems/judge.yml ${SITE_HOST}
