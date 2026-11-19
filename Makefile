ifneq (,$(wildcard .env))
    include .env
    export
endif

.PHONY: up down reset seed migrate

up:
	docker compose up -d

down:
	docker compose down

reset:
	docker compose down -v
	docker compose up -d

schema:
	docker compose exec -T db mysql -u"$(DB_USER)" -p"$(DB_PASS)" "$(DB_NAME)" < database/schema.sql

seed:
	docker compose exec -T db mysql -u"$(DB_USER)" -p"$(DB_PASS)" "$(DB_NAME)" < database/seed.sql