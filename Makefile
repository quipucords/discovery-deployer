#
# Makefile for the Discovery Helm chart.
#
#

all:	help

dry-run:
	@helm install --generate-name --dry-run --debug ./discovery

install:
	@helm install discovery ./discovery

install-instance:
	@helm install --generate-name ./discovery

ls:
	@helm list --filter '^discovery'

uninstall:
	@helm uninstall discovery

help:
	@echo "Makefile for the Discovery Helm Chart."
	@echo ""
	@echo "Make targets:"
	@echo "  help              Shows this output."
	@echo "  dry-run           Does a dry-run Installation and sends generated object to standard output."
	@echo "  install           Installs Discovery onto the current namespace."
	@echo "  install-instance  Installs Discovery with a unique name onto the current namespace."
	@echo "  ls                Show the installed Discovery helm charts."
	@echo "  uninstall         Uninstalls Discovery from the current namespace."

