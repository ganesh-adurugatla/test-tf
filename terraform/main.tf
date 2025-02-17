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

# Add image_tag variable
variable "image_tag" {
  description = "The tag of the Docker image to deploy"
  type        = string
}

# Deployment configuration
resource "google_cloud_run_service" "flask_app" {
  project  = var.project_id
  name     = "flask-app"
  location = "asia-south1"

  template {
    spec {
      containers {
        image = "asia-south1-docker.pkg.dev/${var.project_id}/test-tf/flask-app:${var.image_tag}"
      }
      service_account_name = "ganesh-test@vishakha-403211.iam.gserviceaccount.com"
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Make the service public
resource "google_cloud_run_service_iam_member" "public_access" {
  project  = var.project_id
  service  = google_cloud_run_service.flask_app.name
  location = google_cloud_run_service.flask_app.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
