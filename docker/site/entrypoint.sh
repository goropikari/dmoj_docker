#!/bin/bash

python3 manage.py runbridged &
celery -A dmoj_celery worker &
node websocket/daemon.js &

exec "$@"