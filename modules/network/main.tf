resource "google_compute_network" "this" { # VPC  #! this >> Optional name 
  name = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" { # subnet
  for_each = var.subnets

  name = "${var.vpc_name}-${each.key}-subnet"

  ip_cidr_range = each.value.cidr
  region        = each.value.region

  network = google_compute_network.this.id
}

resource "google_compute_global_address" "G-ip" { # Global IP
  name = "G-ip-I.C(project)"

}