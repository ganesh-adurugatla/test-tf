resource "kubernetes_deployment" "flask_app" {
  metadata {
    name = "flask-app"
  }

  spec {
    selector {
      match_labels = {
        app = "flask-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "flask-app"
        }
      }

      spec {
        container {
          name  = "flask-app"
          image = "${var.region}-docker.pkg.dev/${var.project_id}/test-tf/flask-app:latest"

          # Autopilot requires resource limits
          resources {
            limits = {
              cpu    = "1"
              memory = "2Gi"
            }
            requests = {
              cpu    = "500m"
              memory = "1Gi"
            }
          }
        }
      }
    }
  }
}
