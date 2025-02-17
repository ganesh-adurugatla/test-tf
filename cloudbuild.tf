# cloudbuild.tf

# Cloud Build Trigger configuration
resource "google_cloudbuild_trigger" "flask_app_trigger" {
  name        = "flask-app-deployment"
  description = "Trigger for Flask app deployment"
  
  github {
    owner = "YOUR_GITHUB_OWNER"
    name  = "YOUR_REPO_NAME"
    push {
      branch = "^main$"
    }
  }

  substitutions = {
    _REGION = "asia-south1"
    _CLUSTER = "autopilot-cluster-1-test"
  }

  filename = "cloudbuild.tf.yaml"
}

# Create Artifact Registry repository
resource "google_artifact_registry_repository" "flask_app_repo" {
  location      = "asia-south1"
  repository_id = "test-tf"
  description   = "Docker repository for Flask app"
  format        = "DOCKER"
}

# Service account for Cloud Build
resource "google_service_account" "cloudbuild_sa" {
  account_id   = "cloudbuild-sa"
  display_name = "Cloud Build Service Account"
}

# IAM bindings for the service account
resource "google_project_iam_member" "cloudbuild_sa_roles" {
  for_each = toset([
    "roles/container.developer",
    "roles/artifactregistry.writer",
    "roles/cloudbuild.builds.builder"
  ])
  
  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.cloudbuild_sa.email}"
}

# Variables
variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Default region"
  type        = string
  default     = "asia-south1"
}
