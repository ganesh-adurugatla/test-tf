provider "google" {
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

# This resource defines your Artifact Registry repository
resource "google_artifact_registry_repository" "app_repository" {
  provider      = google
  location      = "asia-south1"
  repository_id = "test-tf"
  description   = "Docker repository for flask application"
  format        = "DOCKER"
}

# This resource updates your deployment
resource "google_cloud_run_service" "flask_app" {
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
