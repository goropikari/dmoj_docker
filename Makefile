run:
	docker compose up

dev-run:
	docker compose -f compose.yml -f compose-dev.yml up

dev-build:
	docker compose down && yes | docker system prune && yes | docker volume prune
	docker compose -f compose.yml -f compose-dev.yml build

image-build:
	docker build -t goropikari/dmoj-site:latest -f docker/site/Dockerfile --no-cache site
	docker build -t goropikari/dmoj-judger:latest -f docker/judger/Dockerfile --no-cache judger

push-image:
	./scripts/push_image
