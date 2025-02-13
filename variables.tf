variable "region" {
  description = "Region for resources"
  type        = string
  default     = "asia-south1"
}

variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

// artifact-registry.tf
resource "google_artifact_registry_repository" "app_repository" {
  provider      = google
  location      = var.region
  repository_id = "test-tf"
  description   = "Docker repository for flask application"
  format        = "DOCKER"
}
