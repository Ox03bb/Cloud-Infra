output "vm_name" {
  value = google_compute_instance.vm.name
}

output "vm_zone" {
  value = google_compute_instance.vm.zone
}

output "vm_machine_type" {
  value = google_compute_instance.vm.machine_type
}

output "vm_network_interfaces" {
  value = google_compute_instance.vm.network_interface
}

output "private_ips" {
  value = [
    for nic in google_compute_instance.vm.network_interface :
    nic.network_ip
  ]
}

output "public_ips" {
  value = [
    for nic in google_compute_instance.vm.network_interface :
    nic.access_config[0].nat_ip if length(nic.access_config) > 0
  ]
}

output "vm_tags" {
  value = google_compute_instance.vm.tags
}

output "vm_startup_script" {
  value = google_compute_instance.vm.metadata_startup_script
}
