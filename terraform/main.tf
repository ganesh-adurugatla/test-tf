# terraform/main.tf
provider "google" {
  project = var.project_id
  region  = "asia-south1"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# Deployment configuration
resource "google_cloud_run_service" "flask_app" {
  project  = var.project_id
  name     = "flask-app"
  location = "asia-south1"

  template {
    spec {
      containers {
        image = "asia-south1-docker.pkg.dev/${var.project_id}/test-tf/flask-app:latest"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
