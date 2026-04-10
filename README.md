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

**3. Apply the remaining deployment manifests:**

```bash
kubectl apply -f deployment/
```

**4. Verify the pods are running:**

```bash
kubectl get pods
```

Wait until all pods show a status of `Running`.

**5. Check the service to find the external address:**

```bash
kubectl get services
```

Once an `EXTERNAL-IP` is assigned, the application will be available at `http://<EXTERNAL-IP>:8080`.

---

## Deleting the Application

To remove all resources created by the deployment manifests, run:

```bash
kubectl delete -f deployment/
```

This will delete the Deployment, Service, ConfigMap, and Secret. To verify everything has been removed:

```bash
kubectl get all
kubectl get configmap
kubectl get secret
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