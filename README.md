# CIS-92 — Cloud Infrastructure (Spring 2026)

> **Author:** Marcos Della  
> **Course:** CIS-92 · Cabrillo College · Spring 2026  
> **Forked from:** [mike-matera/cis-92](https://github.com/mike-matera/cis-92)

---

## Overview

This repository contains starter code and project work for **CIS-92: Cloud Infrastructure**. The project demonstrates how to build, containerize, and deploy a Python web application using **Flask** and **Django**, with Docker as the primary packaging mechanism.

---

## Repository Structure

```
cis-92-sp26/
├── .devcontainer/          # Dev container configuration for VS Code / GitHub Codespaces
├── .github/workflows/      # GitHub Actions CI/CD workflows
├── deployment/             # Deployment configuration files
├── djangotutorial/         # Django web application source code
├── app.py                  # Simple Flask application demonstrating cookies/sessions
├── Dockerfile              # Container image definition
├── .dockerignore           # Files excluded from the Docker build context
├── .gitignore              # Files excluded from version control
└── README.md               # This file
```

---

## Applications

### Flask App (`app.py`)

A minimal Flask application that demonstrates HTTP cookies and basic session management.

| Route | Description |
|---|---|
| `GET /` | Returns a welcome message; greets user by name if a `username` cookie is set |
| `GET /user/<username>` | Sets a `username` cookie and logs the user in |

### Django App (`djangotutorial/`)

A full Django web application configured for containerized deployment. Environment variables control all runtime settings (see below).

---

## Getting Started

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (or a compatible container runtime)
- Python 3.12+ (for local development without Docker)

### Running with Docker

**Build the image:**

```bash
docker build -t cis-92 .
```

**Run the container:**

```bash
docker run -p 8080:8080 cis-92
```

The app will be available at [http://localhost:8080](http://localhost:8080).

### Running the Flask App Locally

```bash
pip install flask
flask --app app.py run
```

---

## Configuration

The Django application is configured via environment variables. The defaults are set in the `Dockerfile` and can be overridden at runtime:

| Variable | Default | Description |
|---|---|---|
| `PORT` | `8080` | Port the application listens on |
| `STUDENT_NAME` | `Marcos Della` | Student name displayed in the app |
| `SITE_NAME` | `cis-92.geekstyle.net` | Public hostname of the site |
| `SECRET_KEY` | `fixme-54321-12345` | Django secret key — **change before deploying!** |
| `DEBUG` | `1` | Enable Django debug mode (`0` to disable) |
| `DATA_DIR` | `/data` | Directory for persistent data storage |
| `DJANGO_SUPERUSER_USERNAME` | `test` | Django admin superuser username |
| `DJANGO_SUPERUSER_PASSWORD` | `test` | Django admin superuser password |
| `DJANGO_SUPERUSER_EMAIL` | `test@test.test` | Django admin superuser email |

> ⚠️ **Security Note:** The default `SECRET_KEY` and superuser credentials are placeholders. Always override these with strong, unique values in any non-development environment.

---

## Dependencies

| Package | Version |
|---|---|
| Python | 3.12.3 |
| Django | 6.0.1 |
| psutil | 7.2.2 |

---

## CI/CD

This repository includes GitHub Actions workflows (`.github/workflows/`) for automated testing and deployment. Releases are tagged using a milestone scheme (e.g., `milestone-5.2`).

---

## Development Environment

A **Dev Container** configuration is included in `.devcontainer/`, enabling a fully reproducible development environment in [VS Code](https://code.visualstudio.com/docs/devcontainers/containers) or [GitHub Codespaces](https://github.com/features/codespaces).

---

## License

This project is for educational purposes as part of the CIS-92 course curriculum at Cabrillo College.