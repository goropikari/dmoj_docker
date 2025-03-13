```
docker compose up --build -d

bash scripts/setup.sh

http://localhost
```


```
docker compose exec app python3 manage.py loaddata language
docker compose exec app python3 manage.py loaddata judgers
```