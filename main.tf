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

locals {
  vms = {
    vm-1 = {
      name = "vm-1"
      zone = "us-central1-a"
      network_interfaces = [
        {
          network    = google_compute_network.vpc.self_link
          subnetwork = google_compute_subnetwork.subnet.self_link
        }
      ]
    }
    vm-2 = {
      name = "vm-2"
      zone = "us-central1-a"
      network_interfaces = [
        {
          network    = google_compute_network.vpc.self_link
          subnetwork = google_compute_subnetwork.subnet.self_link
        }
      ]
    }
  }
}

resource "google_compute_network" "vpc" {
  name                    = "cloud-infra-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "cloud-infra-subnet"
  ip_cidr_range = "10.10.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc.id
}

module "vms" {
  for_each = local.vms

  source = "./modules/vms"

  name               = each.value.name
  zone               = each.value.zone
  network_interfaces = each.value.network_interfaces
}


