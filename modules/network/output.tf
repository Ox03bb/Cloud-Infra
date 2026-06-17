# VPC outputs
output "network_id" {
  value = google_compute_network.this.id
}

output "vpc_name" {
  value = google_compute_network.this.name
}

output "vpc_self_link" {
  value = google_compute_network.this.self_link
}

output "subnet_ids" {
  value = {
    for subnet_key, subnet in google_compute_subnetwork.subnet : subnet_key => subnet.id
  }
}

output "subnet_self_links" {
  value = {
    for subnet_key, subnet in google_compute_subnetwork.subnet : subnet_key => subnet.self_link
  }
}

output "subnet_cidrs" {
  value = {
    for subnet_key, subnet in google_compute_subnetwork.subnet : subnet_key => subnet.ip_cidr_range
  }
}

output "subnet_regions" {
  value = {
    for subnet_key, subnet in google_compute_subnetwork.subnet : subnet_key => subnet.region
  }
}

output "global_ip" {
  value = try(google_compute_global_address.global_ip[0].address, null)
}