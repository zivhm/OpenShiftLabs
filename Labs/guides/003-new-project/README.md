# 003-New Project — Creating namespaces/projects with quotas and limits

This module introduces the concepts of projects (namespaces), resource quotas, and limits in OpenShift.

## Objectives

- Create namespaces/projects and configure resource quotas.
- Apply limit ranges and constraints for CPU/memory.
- Manage project lifecycle and resource cleanup.

## Tasks

1. Create a new project and switch to it: `oc new-project sample-project`.
2. Define `ResourceQuota` and `LimitRange` manifests and apply them.
3. Deploy a pod and verify quota enforcement.

Estimated time: 25–45 minutes

