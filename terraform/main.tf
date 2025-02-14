# terraform/main.tf
# Configure the Google Cloud provider
provider "google" {
  region  = "asia-south1"
}

# Configure Terraform itself
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# Update existing deployment
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