resource "kubernetes_deployment" "app" {
  metadata {
    name = "app-deployment"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "my-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "my-app"
        }
      }

      spec {
        container {
          image = "${google_artifact_registry_repository.app_repository.location}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.app_repository.repository_id}/app:${var.image_tag}"
          name  = "app"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}
