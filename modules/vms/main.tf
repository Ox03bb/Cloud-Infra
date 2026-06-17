resource "google_compute_instance" "vm" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  tags = var.tags

  metadata_startup_script = var.startup_script

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  dynamic "network_interface" {
    for_each = var.network_interfaces

    content {
      network    = network_interface.value.network
      subnetwork = network_interface.value.subnetwork
      network_ip = try(network_interface.value.network_ip, null)

      dynamic "access_config" {
        for_each = var.is_public ? [1] : []

      content {}
    }
    }
  }
}