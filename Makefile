run:
	docker compose up

dev-run:
	docker compose -f compose.yml -f compose-dev.yml up

dev-build:
	docker compose down && yes | docker system prune && yes | docker volume prune
	docker compose -f compose.yml -f compose-dev.yml build --no-cache

image-build:
	docker build -t goropikari/dmoj-site:debug -f site/Dockerfile --no-cache site
	docker build -t goropikari/dmoj-judger:debug -f judger/Dockerfile --no-cache judger

push-image:
	docker login
	docker push goropikari/dmoj-site:debug
	docker push goropikari/dmoj-judger:debug
