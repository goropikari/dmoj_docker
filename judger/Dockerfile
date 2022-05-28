FROM ubuntu:20.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y libseccomp-dev python3-pip git
RUN pip3 install dmoj


RUN mkdir -p /problems
COPY ./problems/judge.yml /problems

RUN git clone --depth 1 https://github.com/goropikari/docs /problems/docs && \
    cd /problems && \
    cp -r docs/problem_examples/standard/aplusb/ .

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd dmoj
USER dmoj
CMD sleep 30 && dmoj -c /problems/judge.yml web
