resource "google_compute_global_address" "global_ip" { # Global IP
  name = "${var.vpc_name}-global-ip"

}
resource "google_compute_network" "this" { # VPC  #! this >> Optional name 
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" { # subnet
  for_each = var.subnets

  name = "${var.vpc_name}-${each.key}-subnet"

  ip_cidr_range = each.value.cidr
  region        = each.value.region

  network = google_compute_network.this.id
}

resource "google_compute_firewall" "firewall" { # Firewall
  count = length(var.firewall_allow) > 0 && length(var.firewall_source_ranges) > 0 && length(var.firewall_target_tags) > 0 ? 1 : 0

  name    = "${var.vpc_name}-firewall"
  network = google_compute_network.this.name

  dynamic "allow" {
    for_each = var.firewall_allow

    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  source_ranges = var.firewall_source_ranges
  target_tags   = var.firewall_target_tags
}