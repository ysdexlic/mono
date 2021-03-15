## mono

Example monorepo building using github actions.

It:
- Detects changed files
- Creates a dependency map
- Runs matrix of builds for each changed service
- For each service:
  - Builds docker image and pushes to container registry
  - Updates the [config repo](https://github.com/ysdexlic/mono-config) with the
    updated image digest
  - Pushes changes to config repo
- Changes in the config repo will then be picked up by ArgoCD with manifests
  created by kustomize.
