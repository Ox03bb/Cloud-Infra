resource "google_compute_global_address" "global_ip" { # Global IP
  count = var.is_public_vpc ? 1 : 0

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
  for_each = {
    for index, rule in var.firewall_rules : index => rule
    if length(rule.allow) > 0 && length(rule.source_ranges) > 0 && length(rule.target_tags) > 0
  }

  name    = coalesce(try(each.value.name, null), "${var.vpc_name}-firewall-${each.key}")
  network = google_compute_network.this.name

  dynamic "allow" {
    for_each = each.value.allow

    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  source_ranges = each.value.source_ranges
  target_tags   = each.value.target_tags
}