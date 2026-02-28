include makefiles/vars.mk

.PHONY: cluster-create cluster-delete image-import

cluster-create:
	k3d cluster create $(CLUSTER_NAME) --agents 2 --port "8080:80@loadbalancer"
	@echo "cluster created"

cluster-delete:
	k3d cluster delete $(CLUSTER_NAME)
	@echo "cluster deleted"

image-import:
	k3d image import $(IMAGE_NAME) -c $(CLUSTER_NAME)
	@echo "image imported"