# Makefile for the Case Study K
#
#

NAMESPACE ?= default
DEPLOYMENT_NAME ?= web-server

local-install: k-start vagrant istio deploy ## Deploy the project locally

package: ## Create a Helm Chart package for the web-server
	@helm package . -d target/

vagrant: 
	@vagrant up

deploy: ## Deploy the web-server Helm Chart
	@scripts/deploy.py $(NAMESPACE) $(DEPLOYMENT_NAME)

k-start: ## Start minikube cluster
	@minikube start --memory=16384 --cpus=4

istio: ## Deploy and update Istio
	@scripts/istio.sh all

cleanup: ## Cleans all local generated files
	@rm -f target/*
	@vagrant destroy --force
	@find . -name '.terraform*' -exec rm -rf {} +
	@minikube delete

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: terraform-deploy package vagrant cleanup deploy k-start istio local-install help 

.DEFAULT_GOAL := help
