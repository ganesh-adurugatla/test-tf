resource "google_container_cluster" "primary" {
  name     = "app-cluster"
  location = var.region

  initial_node_count = 1
  
  node_config {
    machine_type = "e2-medium"
  }
}
