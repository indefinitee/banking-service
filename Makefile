include makefiles/vars.mk
include makefiles/postgres-local.mk
include makefiles/migrate.mk
include makefiles/cluster.mk
include makefiles/k8s-resources.mk
include makefiles/dev.mk
include makefiles/utils.mk

.PHONY: help
help:
	@echo "📦 Доступные команды:"
	@echo ""
	@echo "🐘 Локальный PostgreSQL:"
	@echo "  make postgres     - запустить PostgreSQL в Docker"
	@echo "  make createdb     - создать БД simple_bank"
	@echo "  make dropdb       - удалить БД"
	@echo ""
	@echo "🔄 Миграции:"
	@echo "  make migrateup    - накатить все миграции"
	@echo "  make migratedown  - откатить все миграции"
	@echo "  make migrateup1   - накатить 1 миграцию"
	@echo "  make migratedown1 - откатить 1 миграцию"
	@echo ""
	@echo "☸️ K3d кластер:"
	@echo "  make cluster-create - создать кластер"
	@echo "  make cluster-delete - удалить кластер"
	@echo "  make image-import   - импортировать образ"
	@echo ""
	@echo "🎮 Kubernetes ресурсы:"
	@echo "  make namespace-create - создать namespace"
	@echo "  make secret-create    - создать секрет для API"
	@echo "  make postgres-up      - запустить PostgreSQL в k3d"
	@echo "  make api-up           - запустить API"
	@echo "  make api-logs         - логи API"
	@echo "  make api-restart      - перезапустить API"
	@echo ""
	@echo "💻 Разработка:"
	@echo "  make sqlc        - сгенерировать код sqlc"
	@echo "  make test        - запустить тесты"
	@echo "  make server      - запустить сервер локально"
	@echo "  make mock        - сгенерировать моки"
	@echo ""
	@echo "🧹 Утилиты:"
	@echo "  make status      - статус подов в k3d"
	@echo "  make fresh       - полная переустановка (cluster + db + api)"
	@echo "  make clean       - удалить все ресурсы (кроме кластера)"