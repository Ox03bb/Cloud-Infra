terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "project-745fd197-4b37-4048-90a"
  region  = "us-central1"
}


