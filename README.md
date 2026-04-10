# CIS-92 — Cloud Infrastructure (Spring 2026)

> **Author:** Marcos Della  
> **Course:** CIS-92 · Cabrillo College · Spring 2026  
> **Forked from:** [mike-matera/cis-92](https://github.com/mike-matera/cis-92)

---

## Overview

This repository contains starter code and project work for **CIS-92: Cloud Infrastructure**. The project demonstrates how to build, containerize, and deploy a Python Django web application on Kubernetes.

---

## Configuration

The application is configured through two Kubernetes manifests in the `deployment/` directory.

### `config.yaml` (ConfigMap)

| Variable Name | Default Value | Description |
|---|---|---|
| `PORT` | `8080` | Port the application listens on |
| `STUDENT_NAME` | `Marcos Della` | Student name displayed in the app |
| `SITE_NAME` | `django.geekstyle.net` | Public hostname of the site |
| `DATA_DIR` | `/data` | Directory for persistent data storage |
| `DEBUG` | `1` | Django debug mode (`1` = on, `0` = off) |

### `secret.yaml` (Secret)

| Variable Name | Default Value | Description |
|---|---|---|
| `SECRET_KEY` | `this-is-a-good-key` | Django cryptographic secret key |
| `DJANGO_SUPERUSER_USERNAME` | `testing` | Django admin superuser username |
| `DJANGO_SUPERUSER_EMAIL` | `testing@testing.com` | Django admin superuser email |
| `DJANGO_SUPERUSER_PASSWORD` | `testing` | Django admin superuser password |

> ⚠️ **Security Note:** The values in `secret.yaml` are base64-encoded placeholders. Replace them with strong, unique values before deploying to any non-development environment. Never commit real secrets to version control.

---

## Deploying on Kubernetes

These instructions assume you have `kubectl` configured and pointed at your cluster.

**1. Apply the ConfigMap:**

```bash
kubectl apply -f deployment/config.yaml
```

**2. Apply the Secret:**

```bash
kubectl apply -f deployment/secret.yaml
```

**3. Apply the PersistentVolumeClaim (first time only):**

```bash
kubectl apply -f deployment/pvc.yaml
```

This requests 1Gi of storage. Kubernetes will automatically provision and bind the volume. You only need to do this once — the PVC persists across pod restarts and redeployments.

**4. Apply the Pod:**

```bash
kubectl apply -f deployment/pod.yaml
```

**5. Apply the Service:**

```bash
kubectl apply -f deployment/service.yaml
```

**6. Verify the pod is running:**

```bash
kubectl get pods
```

Wait until `django-pod` shows a status of `Running`.

**7. Get the external IP address:**

```bash
kubectl get services
```

Once `django-svc` shows an `EXTERNAL-IP`, the application will be available at `http://<EXTERNAL-IP>`.

---

## Deleting the Application

To remove the pod and service (but keep the PVC and its data intact):

```bash
kubectl delete -f deployment/pod.yaml
kubectl delete -f deployment/service.yaml
kubectl delete -f deployment/config.yaml
kubectl delete -f deployment/secret.yaml
```

To also permanently delete the PVC and all stored data:

```bash
kubectl delete -f deployment/pvc.yaml
```

> ⚠️ Deleting the PVC is irreversible — all data in the `/data` volume will be lost.

To verify everything has been removed:

```bash
kubectl get pods
kubectl get services
kubectl get pvc
```

---

## Repository Structure

```
cis-92-sp26/
├── .devcontainer/          # Dev container configuration for VS Code / GitHub Codespaces
├── .github/workflows/      # GitHub Actions CI/CD workflows
├── deployment/             # Kubernetes manifests (config.yaml, secret.yaml, etc.)
├── djangotutorial/         # Django web application source code
├── app.py                  # Simple Flask app demonstrating cookies/sessions
├── Dockerfile              # Container image definition
├── .dockerignore           # Files excluded from the Docker build context
├── .gitignore              # Files excluded from version control
└── README.md               # This file
```

---

## Development Environment

A **Dev Container** configuration is included in `.devcontainer/`, enabling a fully reproducible development environment in [VS Code](https://code.visualstudio.com/docs/devcontainers/containers) or [GitHub Codespaces](https://github.com/features/codespaces).

To run the application locally with Docker:

```bash
docker build -t cis-92 .
docker run -p 8080:8080 cis-92
```

The app will be available at [http://localhost:8080](http://localhost:8080).