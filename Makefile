#
# Makefile for the Discovery Helm chart.
#
#

all:	help

dry-run:
	helm install --generate-name --dry-run --debug ./discovery

install:
	helm install --generate-name ./discovery

help:
	@echo "Makefile for the Discovery Helm Chart."
	@echo ""
	@echo "Make targets:"
	@echo "  help			 Shows this output."
	@echo "  dry-run   Does a dry-run Installation and sends generated object to standard output."
	@echo "  install   Does an Installation of discovery with a genrated name onto the current namespace."

