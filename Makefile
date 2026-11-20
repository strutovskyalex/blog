ifneq (,$(wildcard src/.env))
    include src/.env
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

composer-install:
	docker compose exec web composer install

schema:
	docker compose exec -T db mysql -u"$(DB_USER)" -p"$(DB_PASS)" "$(DB_NAME)" < database/schema.sql

seed:
	docker compose exec -T db mysql -u"$(DB_USER)" -p"$(DB_PASS)" "$(DB_NAME)" < database/seed.sql