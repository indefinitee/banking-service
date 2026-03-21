.PHONY: sqlc test server mock redis

sqlc:
	sqlc generate

test:
	go test -v -cover -short ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/indefinitee/simplebank/db/sqlc Store
	mockgen -package mockwk -destination worker/mock/distributor.go github.com/indefinitee/simplebank/worker TaskDistributor

redis:
	docker run --name redis -p 6379:6379 -d redis:8-alpine