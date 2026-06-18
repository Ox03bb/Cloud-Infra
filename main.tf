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
    mynetwork = {
      vpc_name = "mynetwork"
      is_public_vpc = true
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
    privatenet = {
      vpc_name = "privatenet"
      is_public_vpc = false
      subnets = {
        subnet-1 = {
          cidr   = "172.16.0.0/20"
          region = "us-central1"
        }
        subnet-2 = {
          cidr   = "172.20.0.0/20"
          region = "europe-west1"
        }
      }
    }
    managmentnet = {
      vpc_name = "managmentnet"
      is_public_vpc = false
      subnets = {
        subnet-1 = {
          cidr   = "10.130.0.0/20"
          region = "us-central1"
        }
      }
    }

  }

  vms = {
    # mynetwork VMs
    vm-1 = {
      name       = "mynet-us-vm-1"
      zone       = "us-central1-a"
      vpc        = "mynetwork"
      subnet     = "subnet-1"
      network_ip = "10.128.0.2"
    }
    vm-2 = {
      name       = "mynet-us-vm-2"
      zone       = "us-central1-a"
      vpc        = "mynetwork"
      subnet     = "subnet-1"
      network_ip = "10.128.0.3"
    }
    vm-3 = {
      name       = "mynet-eu-vm-1"
      zone       = "europe-west1-b"
      vpc        = "mynetwork"
      subnet     = "subnet-2"
      network_ip = "10.132.0.2"
    }

    # private network VMs
    vm-4 = {
      name       = "privatenet-us-vm"
      zone       = "us-central1-a"
      type      = "e2-medium"
      vpc        = "privatenet"
      subnet     = "subnet-1"
      network_ip = "172.16.0.2"
    }

    # managmentnet VMs

    vm-5 = {
      name       = "privatenet-eu-vm"
      zone       = "us-central1-b"
      vpc        = "managmentnet"
      subnet     = "subnet-1"
      network_ip = "10.130.1.1"
    }

    vm-6 = {
      name       = "managmentnet-us-vm"
      zone       = "us-central1-a"
      vpc        = "managmentnet"
      subnet     = "subnet-1"
      network_ip = "10.130.1.2"
    }

    # multi-vpc hub VM
    vm-7 = {
      name         = "appilance-vm"
      zone         = "us-central1-b"
      machine_type = "e2-standard-4"
      network_interfaces = [
        {
          network    = module.networks.mynetwork.network_id
          subnetwork = module.networks.mynetwork.subnet_ids["subnet-1"]
          network_ip = "10.128.0.10"
        },
        {
          network    = module.networks.privatenet.network_id
          subnetwork = module.networks.privatenet.subnet_ids["subnet-1"]
          network_ip = "172.16.0.10"
        },
        {
          network    = module.networks.managmentnet.network_id
          subnetwork = module.networks.managmentnet.subnet_ids["subnet-1"]
          network_ip = "10.130.0.10"
        }
      ]
    }
  }
}

module "networks" {
  for_each = local.vpcs

  source = "./modules/network"

  vpc_name      = each.value.vpc_name
  is_public_vpc = each.value.is_public_vpc
  subnets       = each.value.subnets
}


module "vms" {
  for_each = local.vms

  source = "./modules/vms"

  name = each.value.name
  zone = each.value.zone
  machine_type = try(each.value.machine_type, "e2-micro")
  network_interfaces = try(each.value.network_interfaces, [
    {
      network    = module.networks[each.value.vpc].network_id
      subnetwork = module.networks[each.value.vpc].subnet_ids[each.value.subnet]
      network_ip = each.value.network_ip
    }
  ])
}


#! pubsub module
module "pubsub" {
  source = "./modules/storage/pubsub"

  topic_name        = "events"
  subscription_name = "events-worker"

  labels = {
    environment = "prod"
    team        = "backend"
  }

  ack_deadline_seconds = 30

  subscription_message_retention_duration = "1209600s"

  enable_message_ordering = true

  minimum_backoff = "10s"
  maximum_backoff = "600s"

  publisher_members = [
    # "serviceAccount:api@project-id.iam.gserviceaccount.com"  # Service account must exist before uncommenting
  ]

  subscriber_members = [
    "allAuthenticatedUsers"
  ]
}

#! GCS  
module "gcs" {
  source = "./modules/storage/gcs"

  name          = "cloud-infra-app-bucket-${var.project_id}"
  location      = "US"
  storage_class = "STANDARD"
  force_destroy = false
}