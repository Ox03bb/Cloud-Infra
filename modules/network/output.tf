# VPC outputs
output "vpc_name" {
  value = google_compute_network.this.name
}


output "vpc_ip_range" {
  value = google_compute_network.this.ipv4_range
}

output "vpc_self_link" {
  value = google_compute_network.this.self_link
}

# Subnet outputs
output "subnet_name" {
  value = google_compute_subnetwork.subnet.name
}

output "subnet_cidr" {
  value = google_compute_subnetwork.subnet.ip_cidr_range
}

output "subnet_region" {
  value = google_compute_subnetwork.subnet.region
}

# Global IP outputs
output "global_ip" {
  value = google_compute_global_address.G-ip.address
}
