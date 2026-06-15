resource "google_compute_instance" "vm" { 
      name   = var.name
      machine_type = var.machine_type
    zone         = var.zone



    boot_disk {
      initialize_params {
          image = var.image
      }
    }

    network_interface {
      network = var.network
      subnetwork = var.network
      access_config {}
    }

    metadata_startup_script = var.startup_script 
}