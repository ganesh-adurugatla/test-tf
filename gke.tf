resource "google_container_cluster" "autopilot" {
  name     = "autopilot-cluster-1-test"
  location = var.region

  # Enable Autopilot mode
  enable_autopilot = true

  # Required for Autopilot
  release_channel {
    channel = "REGULAR"
  }

  # Network configuration if needed
  network    = "default"
  subnetwork = "default"
}
