terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.defualt_region
}

locals {
  vpcs = {
    primary = {
      vpc_name = "cloud-infra-primary-vpc"
      subnets = {
        subnet-1 = {
          cidr   = "10.128.0.0/20"
          region = "us-central1"
        }
        subnet-2 = {
          cidr   = "10.132.0.0/20"
          region = "europe-west1"
        }
      }
    }
    secondary = {
      vpc_name = "cloud-infra-secondary-vpc"
      subnets = {
        subnet-3 = {
          cidr   = "10.140.0.0/20"
          region = "us-central1"
        }
      }
    }
  }

  vms = {
    vm-1 = {
      name       = "mynet-us-vm-1"
      zone       = "us-central1-a"
      vpc        = "primary"
      subnet     = "subnet-1"
      network_ip = "10.128.0.2"
    }
    vm-2 = {
      name       = "mynet-us-vm-2"
      zone       = "us-central1-a"
      vpc        = "primary"
      subnet     = "subnet-1"
      network_ip = "10.128.0.3"
    }
    vm-3 = {
      name       = "mynet-eu-vm-1"
      zone       = "europe-west1-b"
      vpc        = "primary"
      subnet     = "subnet-2"
      network_ip = "10.132.0.2"
    }
  }
}

module "networks" {
  for_each = local.vpcs

  source = "./modules/network"

  vpc_name = each.value.vpc_name
  subnets  = each.value.subnets
}


module "vms" {
  for_each = local.vms

  source = "./modules/vms"

  name = each.value.name
  zone = each.value.zone
  network_interfaces = [
    {
      network    = module.networks[each.value.vpc].network_id
      subnetwork = module.networks[each.value.vpc].subnet_ids[each.value.subnet]
      network_ip = each.value.network_ip
    }
  ]
}


