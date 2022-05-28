dev-run:
	docker compose -f compose.yml -f compose-dev.yml up

dev-build:
	docker compose -f compose.yml -f compose-dev.yml build
