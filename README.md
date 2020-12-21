# Fork of NDR Pseudonymisation Service

This is an experimental fork of NDR's [Pseudonymisation Service](https://github.com/publichealthengland/pseudonymisation_service), for testing CI/CD.

## Status

Currently, investigating cacheable container-based CI workflow, using GitHub Actions + GitHub Container Registry.

## Deployment via Terraform

It's possible to deploy to a Kuberenetes cluster, using Terraform. Workspaces are use to track a per-branch state.

Setup:

```bash
cd tf
terraform init
```

Deploying `master`:

```bash
terraform workspace new master
terraform apply
```

Then deploying a new `feature-branch`:

```bash
terraform workspace new feature-branch
terraform apply
```

The re-deploying some updates to `master`:

```bash
terraform workspace select master
terraform apply
```

The application is currently exposed via a `NodePort` Service; if using minikube, `minikube service list` would give a host IP.

```bash
curl -sH "Authorization: Bearer test_user:..." http://192.168.64.2:32353/api/v1/keys
```

## TODO

- validate image label using docker provider?
