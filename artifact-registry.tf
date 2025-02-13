resource "google_artifact_registry_repository" "app_repository" {
  provider = google
  location = var.region
  repository_id = "app-repository"
  description = "Docker repository for application images"
  format = "DOCKER"
}
