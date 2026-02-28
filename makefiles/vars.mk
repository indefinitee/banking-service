NAMESPACE = db
CLUSTER_NAME = dev
IMAGE_NAME = simplebank:latest
DB_CONTAINER = postgres3.23
DB_URL = postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable
K8S_DB_SOURCE = postgresql://root:secret@postgres.db.svc.cluster.local:5432/simple_bank?sslmode=disable