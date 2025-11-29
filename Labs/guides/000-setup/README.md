# 000-Setup — Cluster provisioning and access

This module covers the environment setup required to create a working OpenShift cluster (local or cloud) and gain CLI access.

## Objectives

- Understand the options for running OpenShift locally (CRC, Minikube/OKD) or in the cloud.
- Install `oc`, `kubectl`, and container tools (podman/docker) as required.
- Connect to a cluster and verify access by listing nodes and projects.

## Tasks

1. Provision or start a local cluster (CRC / OKD / Minikube) or create a test cluster in the cloud.
2. Install `oc` CLI and confirm version: `oc version`.
3. Log in and run `oc get nodes` to verify node readiness.
4. Create a practice project: `oc new-project <name>`.

Estimated time: 30–45 minutes

