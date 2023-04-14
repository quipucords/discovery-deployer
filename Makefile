
QPC_NAMESPACE = discovery
QUAY_REGISTRY = quay.io
CRC_SERVER    = api.crc.testing:6443
QUAY_USER     ~= abellott
QPC_IMAGE     = quipucords
QPC_IMAGE_TAG ?= latest
QUAY_REPO     = $(QUAY_USER)/$(QPC_IMAGE)


.PHONY: help init-ocp login-crc login-registry push deploy undeploy

all: help

help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "where <target> is one of:"
	@echo "  init-ocp             - Creates new $(QPC_NAMESPACE) project in OpenShift/CRC"
	@echo "  login-crc            - Logs in as developer to the $(CRC_SERVER)"
	@echo "  login-registry       - Logs in to the registry $(QUAY_REGISTRY)"
	@echo "  push                 - Pushes the quipucords build to $(QUAY_REGISTRY)/$(QUAY_REPO):$(QPC_IMAGE_TAG)"
	@echo "  deploy               - Deploys Discovery to project $(QPC_NAMESPACE)"
	@echo "  undeploy             - Un-Deploys Discovery from project $(QPC_NAMESPACE)"

init-ocp:
	oc new-project $(QPC_NAMESPACE)
	oc project $(QPC_NAMESPACE)

login-crc:
	oc login --username=developer --password=developer api.crc.testing:6443
	oc project $(QPC_NAMESPACE)

login-registry:
	docker login $(QUAY_REGISTRY)

push:
	docker push quipucords $(QUAY_REGISTRY)/$(QUAY_REPO):$(QPC_IMAGE_TAG)

deploy:
	oc project $(QPC_NAMESPACE)
	oc apply -f discovery_template.yaml
	oc new-app --template=discovery

undeploy:
	oc project $(QPC_NAMESPACE)
# Deployments
	oc delete --ignore-not-found=true deployment/discovery-celery-worker
	oc delete --ignore-not-found=true deployment/discovery-quipucords
	oc delete --ignore-not-found=true deployment/discovery-db
	oc delete --ignore-not-found=true deployment/discovery-redis
# Services
	oc delete --ignore-not-found=true services/discovery-server
	oc delete --ignore-not-found=true services/discovery-db
	oc delete --ignore-not-found=true services/discovery-redis
# Routes
	oc delete --ignore-not-found=true routes/discovery-server
# Physical Volume Claims
	oc delete --ignore-not-found=true pvc/discovery-data-volume-claim
	oc delete --ignore-not-found=true pvc/discovery-log-volume-claim
# Service Accounts
	oc delete --ignore-not-found=true sa/discovery-sa
	oc delete --ignore-not-found=true -f discovery_template.yaml

