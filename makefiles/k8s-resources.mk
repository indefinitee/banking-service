include makefiles/vars.mk

.PHONY: namespace-create secret-create postgres-up api-up api-logs api-restart

namespace-create:
	kubectl create namespace $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -
	@echo "namespace '$(NAMESPACE)' created"

secret-create:
	kubectl create secret generic api-secret \
		--from-literal=DB_SOURCE="$(K8S_DB_SOURCE)" \
		-n $(NAMESPACE) \
		--dry-run=client -o yaml | kubectl apply -f -
	@echo "secret created"

postgres-up:
	kubectl apply -f k8s/postgres.yaml
	@echo "PostgreSQL up successful"
	@kubectl wait --for=condition=ready pod -l app=postgres -n $(NAMESPACE) --timeout=60s || true

api-up: secret-create
	kubectl apply -f k8s/api-deployment.yaml
	@echo "api up successful"

api-logs:
	kubectl logs -n $(NAMESPACE) -l app=simplebank-api -f

api-restart:
	kubectl delete pods -n $(NAMESPACE) -l app=simplebank-api
	@echo "api restarted"