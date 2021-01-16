service := service-name
overlay := dev
tag := latest

# TODO: get repo
repo := eu.gcr.io/ysdexlic-platform

repo-dev := $(repo)
repo-staging := $(repo)
repo-prod := $(repo)-production

.PHONY: ci-init
ci-init: ## fetches digest hash
	digest=$$(gcloud container images describe $(repo-$(overlay))/$(service):$(tag) --format="value(image_summary.digest)"); \
	yq n $(service).digest $${digest} > $(overlay)-conf.yaml

.PHONY: ci
ci: ## sets tag for deployment
	digest=$$(yq read $(overlay)-conf.yaml $(service).digest); \
	cd mono-config/$(service)/overlays/$(overlay) \
	&& kustomize edit set image $(repo)/$(service)=$(repo-$(overlay))/$(service)@$${digest}

.PHONY: ci-prep
ci-prep: ## prepares for deployment
	rm -rf mono-config \
	&& git clone git@github.com:ysdexlic/mono-config.git \
	&& cd mono-config \
	&& git pull origin master

.PHONY: ci-finish
ci-finish: ## prepares for deployment
	cd mono-config \
	&& git add . \
	&& git diff-index --quiet HEAD || git commit -m "Update $(service) image tags from CI (${BUILDKITE_BRANCH}) ${BUILDKITE_BUILD_URL}" \
	&& git push origin master

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
