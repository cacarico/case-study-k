# Makefile for the Case Study K
#
terraform-deploy:
	@scripts/deploy-terraform.sh

package: ## Create a Helm Chart package for the web-server
	@helm package helm/web/ -d target/

vagrant: 
	@vagrant up

cleanup: ## Cleans the target 
	@rm -f target/*
	@vagrant destroy --force
	@find . -name '.terraform*' -type f -delete

deploy: ## Deploy the web-server Helm Chart
	@helm upgrade web-server-test helm/web/

k-start: ## Start minikube cluster
	@minikube start --memory=16384 --cpus=4

istio: ## Deploy and update Istio
	@istioctl install -f istio-operator.yaml -y

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: terraform-deploy package vagrant cleanup deploy k-start istio help 

.DEFAULT_GOAL := help
