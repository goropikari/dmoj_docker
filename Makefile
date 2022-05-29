run:
	docker compose up

dev-run:
	docker compose -f compose.yml -f compose-dev.yml up

dev-build:
	docker compose down && yes | docker system prune && yes | docker volume prune
	docker compose -f compose.yml -f compose-dev.yml build

dev-site-build:
	docker build -t goropikari/dmoj-site:dev -f docker/site/Dockerfile docker/site

dev-site-build-no-cache:
	docker build -t goropikari/dmoj-site:dev -f docker/site/Dockerfile --no-cache docker/site

web-sh:
	docker compose exec -it web bash

judger-sh:
	docker compose exec -it judger bash

image-build:
	docker build -t goropikari/dmoj-site:latest -f docker/site/Dockerfile docker/site
	docker build -t goropikari/dmoj-judger:latest -f docker/judger/Dockerfile docker/judger

image-build-no-cache:
	docker build -t goropikari/dmoj-site:latest -f docker/site/Dockerfile --no-cache docker/site
	docker build -t goropikari/dmoj-judger:latest -f docker/judger/Dockerfile --no-cache docker/judger

push-image: image-build-no-cache
	./scripts/push_judger_image
	./scripts/push_site_image

push-site-image:
	docker build -t goropikari/dmoj-site:latest -f docker/site/Dockerfile --no-cache docker/site
	./scripts/push_site_image
