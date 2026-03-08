.PHONY: proto

clear_proto:
	rm -f pb/*.go

proto: clear_proto
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative \
    --go-grpc_out=pb --go-grpc_opt=paths=source_relative \
    proto/*.proto
