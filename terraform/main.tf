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
