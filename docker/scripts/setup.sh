#!/bin/bash

docker compose exec app python3 manage.py migrate
docker compose exec app ./make_style.sh
docker compose exec app python3 manage.py collectstatic
docker compose exec app python3 manage.py compilemessages
docker compose exec app python3 manage.py compilejsi18n

docker compose exec app python3 manage.py loaddata navbar
docker compose exec app python3 manage.py loaddata demo

# docker compose cp ../config/language.json app:/site/judge/fixtures/
docker compose exec app python3 manage.py loaddata language
# docker compose cp ../config/judgers.json app:/site/judge/fixtures/
docker compose exec app python3 manage.py loaddata judgers

docker compose exec app python3 manage.py createsuperuser
