include makefiles/vars.mk

.PHONY: postgres createdb dropdb

postgres:
	docker run --name $(DB_CONTAINER) --network bank-network -p 5432:5432 \
		-e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:alpine3.23

createdb:
	docker exec -it $(DB_CONTAINER) createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it $(DB_CONTAINER) dropdb simple_bank