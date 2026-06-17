resource "google_sql_database_instance" "db_instance" {
  name             = var.name
  database_version = var.database_version
  region           = var.region

  settings {
    tier      = var.tier
    disk_size = var.disk_size
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.private_network
    }
  }
}

resource "google_sql_database" "default_db" {
  name     = "appdb"
  instance = google_sql_database_instance.db_instance.name
}
