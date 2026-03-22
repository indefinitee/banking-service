# 🏦 Banking Service

A production-ready backend banking microservice built with **Go**, exposing both a **gRPC** and **HTTP REST** (via gRPC-Gateway) API. Includes async background task processing, JWT/PASETO authentication, PostgreSQL with type-safe queries, Redis-backed job queues, and full Kubernetes deployment support.

> Pet project based on the [Tech School Backend Master Class](https://github.com/techschool/simplebank) course, extended and adapted independently.

---

## ✨ Features

- **Dual API layer** — gRPC server + HTTP gateway (grpc-gateway) running simultaneously
- **Authentication** — PASETO / JWT token-based auth with access & refresh tokens
- **Async task processing** — Redis + [Asynq](https://github.com/hibiken/asynq) for background jobs (e.g. email verification)
- **Email notifications** — Gmail SMTP sender integrated into the worker pipeline
- **Type-safe SQL** — [sqlc](https://sqlc.dev/) for compile-time safe database queries
- **Auto migrations** — [golang-migrate](https://github.com/golang-migrate/migrate) runs on startup
- **Swagger UI** — served at `/swagger/` via embedded statik filesystem
- **Kubernetes-ready** — K3d cluster config + manifests in `k8s/`
- **CI/CD** — GitHub Actions workflow included

---

## 🗂 Project Structure

```
banking-service/
├── api/            # Legacy Gin REST API (kept for reference)
├── db/             # sqlc config, migrations, generated query code
├── doc/            # Swagger/OpenAPI spec + statik embedded FS
├── gapi/           # gRPC server handlers + HTTP logger middleware
├── k8s/            # Kubernetes manifests (deployment, service, secrets)
├── mail/           # Gmail sender implementation
├── makefiles/      # Modular Makefile includes
├── pb/             # Generated Protobuf Go code
├── proto/          # .proto service definitions
├── token/          # PASETO / JWT token maker
├── util/           # Config loader, helpers, validators
├── val/            # gRPC request validators
├── worker/         # Asynq task distributor & processor
├── main.go         # Entry point
├── Dockerfile
├── docker-compose.yaml
└── app.env         # Local environment config
```

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| Language | Go 1.21+ |
| Transport | gRPC + gRPC-Gateway (HTTP/JSON) |
| REST (legacy) | Gin |
| Database | PostgreSQL (pgxpool) |
| ORM / Queries | sqlc |
| Migrations | golang-migrate |
| Auth | PASETO tokens (access + refresh) |
| Async Queue | Redis + Asynq |
| Email | Gmail SMTP |
| Docs | Swagger UI (statik) |
| Containerization | Docker, Docker Compose |
| Orchestration | Kubernetes (K3d) |
| CI/CD | GitHub Actions |
| Logging | zerolog |

---

## ⚙️ Configuration

Copy `app.env` and adjust values:

```env
ENVIRONMENT=development

DB_SOURCE=postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable
MIGRATION_URL=file://db/migration

HTTP_SERVER_ADDRESS=0.0.0.0:8080
GRPC_SERVER_ADDRESS=0.0.0.0:9090

TOKEN_SYMMETRIC_KEY=12345678901234567890123456789012
ACCESS_TOKEN_DURATION=15m
REFRESH_TOKEN_DURATION=24h

REDIS_ADDRESS=0.0.0.0:6379

EMAIL_SENDER_NAME=Your Name
EMAIL_SENDER_ADDRESS=your@gmail.com
EMAIL_SENDER_PASSWORD=your_app_password
```

---

## 🚀 Getting Started

### Prerequisites

- Go 1.21+
- Docker & Docker Compose
- `make`
- `sqlc`, `protoc`, `golang-migrate` (optional, for code generation)

### Local run (Docker Compose)

```bash
# Start PostgreSQL + Redis
docker-compose up -d

# Run the server
make server
```

### Local run (manual)

```bash
# Start PostgreSQL in Docker
make postgres
make createdb

# Apply migrations
make migrateup

# Start server
make server
```

### Run tests

```bash
make test
```

---

## 🌐 API

### HTTP Gateway (REST)

Available at `http://localhost:8080`

Swagger UI: `http://localhost:8080/swagger/`

### gRPC

Available at `localhost:9090`

Use [Evans](https://github.com/ktr0731/evans) for interactive exploration:

```bash
make evans
```

---

## ☸️ Kubernetes (K3d)

```bash
# Create local cluster
make cluster-create

# Build & import image
make image-import

# Deploy all resources
make namespace-create
make secret-create
make postgres-up
make api-up

# Check status
make status

# View logs
make api-logs

# Full teardown + fresh deploy
make fresh
```

---

## 🗄 Database

Migrations are in `db/migration/` and run automatically on server start.

To regenerate sqlc code after changing SQL queries:

```bash
make sqlc
```

To regenerate DB schema documentation:

```bash
make db_docs
make db_schema
```

---

## 📡 Proto / gRPC

After modifying `.proto` files, regenerate Go code:

```bash
make proto
```

Generated code goes into `pb/`.

---

## 🔄 CI/CD

GitHub Actions workflow is defined in `.github/workflows/`. It runs tests on every push to `main`.

---

## 📋 All Make Commands

```bash
make help
```
