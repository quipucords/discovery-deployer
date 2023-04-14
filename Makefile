
DISCOVERY_NAMESPACE   = discovery
QUAY_REGISTRY         = quay.io
QUAY_USER             = $(error Please define QUAY_USER)
QUAY_PASSWORD         = $(error Please define QUAY_PASSWORD)
QUAY_EMAIL            = $(error Please define QUAY_EMAIL)
CRC_SERVER            = api.crc.testing:6443
QUIPUCORDS_IMAGE      = quipucords
QUIPUCORDS_IMAGE_TAG  ?= latest
DISCOVERY_SERVER_IMAGE = $(QUAY_REGISTRY)/$(QUAY_USER)/$(QUIPUCORDS_IMAGE):$(QUIPUCORDS_IMAGE_TAG)

.PHONY: help login-crc init-ocp login-registry push deploy undeploy

all: help

help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "where <target> is one of:"
	@echo "  login-crc            - Logs in as developer to the $(CRC_SERVER)"
	@echo "  init-ocp             - Creates new $(DISCOVERY_NAMESPACE) project in OpenShift/CRC"
	@echo "  login-registry       - Logs in to the registry $(QUAY_REGISTRY)"
	@echo "  push                 - Pushes the quipucords build to $(QPC_REPO_IMAGE)"
	@echo "  create-pull-secret   - Creates the discovery-pull-secret in project $(DISCOVERY_NAMESPACE)"
	@echo "                         make create-pull-secret QUAY_USER=... QUAY_PASSWORD=... QUAY_EMAIL=..."
	@echo "  deploy               - Deploys Discovery to project $(DISCOVERY_NAMESPACE)"
	@echo "  undeploy             - Un-Deploys Discovery from project $(DISCOVERY_NAMESPACE)"

require-quay-user:
	test $(QUAY_USER)

login-crc:
	oc login --username=developer --password=developer $(CRC_SERVER)

init-ocp:
	oc new-project $(DISCOVERY_NAMESPACE)
	oc project $(DISCOVERY_NAMESPACE)

login-registry:
	docker login $(QUAY_REGISTRY)

push:
	docker push quipucords $(DISCOVERY_SERVER_IMAGE)

create-pull-secret:
	QUAY_REGISTRY=$(QUAY_REGISTRY) DISCOVERY_NAMESPACE=$(DISCOVERY_NAMESPACE) ./create_pull_secret.sh $(QUAY_USER) $(QUAY_PASSWORD) $(QUAY_EMAIL)

deploy:
	oc project $(DISCOVERY_NAMESPACE)
	oc apply -f discovery_template.yaml
	oc new-app --template=discovery --param=DISCOVERY_SERVER_IMAGE=$(DISCOVERY_SERVER_IMAGE)

undeploy:
	oc project $(DISCOVERY_NAMESPACE)
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

