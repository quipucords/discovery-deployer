#
# Makefile for the Discovery Helm chart.
#
# Optional Argument: SERVER_PASSWORD="..."
#

test_password = "testpassword1"

all:	help

dry-run:
	@helm install --generate-name --dry-run --debug ./discovery --set server.password="$(test_password)")

install:
	@if test -n "${SERVER_PASSWORD}"; then \
	  helm install discovery ./discovery --set server.password="${SERVER_PASSWORD}"; \
	else \
	  helm install discovery ./discovery; \
	fi

install-instance:
	@if test -n "${SERVER_PASSWORD}"; then \
	  helm install --generate-name ./discovery --set server.password="${SERVER_PASSWORD}"; \
	else \
	  helm install --generate-name ./discovery; \
	fi

lint:
	@helm lint ./discovery --set server.password="$(test_password)"

ls:
	@helm list --filter '^discovery'

uninstall:
	@helm uninstall discovery

help:
	@echo "Makefile for the Discovery Helm Chart."
	@echo ""
	@echo "Optional parameters for install directivees:"
	@echo "  SERVER_PASSWORD=..."
	@echo ""
	@echo "Make targets:"
	@echo "  help                       Shows this output."
	@echo "  dry-run                    Does a dry-run Installation and sends generated object to standard output."
	@echo "  install <params>           Installs Discovery onto the current namespace."
	@echo "  install-instance <params>  Installs Discovery with a unique name onto the current namespace."
	@echo "  lint                       Run Lint against the Discovery Chart"
	@echo "  ls                         Show the installed Discovery helm charts."
	@echo "  uninstall                  Uninstalls Discovery from the current namespace."

