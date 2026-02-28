include makefiles/vars.mk

.PHONY: status fresh clean

status:
	@echo "=== PODS ==="
	@kubectl get pods -n $(NAMESPACE) 2>/dev/null || echo "❌ Нет namespace $(NAMESPACE)"
	@echo ""
	@echo "=== SERVICES ==="
	@kubectl get svc -n $(NAMESPACE) 2>/dev/null || echo "❌ Нет сервисов"
	@echo ""
	@echo "=== SECRETS ==="
	@kubectl get secrets -n $(NAMESPACE) 2>/dev/null || echo "❌ Нет секретов"

fresh: cluster-delete cluster-create image-import namespace-create secret-create postgres-up api-up
	@echo "watch logs: make api-logs"

clean:
	kubectl delete -f k8s/api-deployment.yaml --ignore-not-found=true
	kubectl delete -f k8s/postgres.yaml --ignore-not-found=true
	kubectl delete secret api-secret -n $(NAMESPACE) --ignore-not-found=true
	kubectl delete namespace $(NAMESPACE) --ignore-not-found=true
	@echo "✅ Всё очищено (кроме кластера)"