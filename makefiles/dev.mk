.PHONY: sqlc test server mock

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/indefinitee/simplebank/db/sqlc Store