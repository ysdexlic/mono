branch := dev
digest := digest
config-repo := mono-config
build-url := https://github.com/ysdexlic/mono/actions/

service := service-name
overlay := dev
tag := latest

repo := ghcr.io/ysdexlic

.PHONY: ci
ci: ## sets tag for deployment
	cd $(config-repo)/lib/$(service)/overlays/$(overlay) \
	&& kustomize edit set image $(repo)/$(service)=$(repo)/$(service)@$(digest)

.PHONY: ci-finish
ci-finish: ## prepares for deployment
	cd $(config-repo) \
	&& git add . \
	&& git diff-index --quiet HEAD || git commit -m "Update $(service) image tags from CI ($(branch)) $(build-url)" \
	&& git push origin main

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
