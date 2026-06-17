resource "google_redis_instance" "redis" {
  name               = var.name
  region             = var.region
  tier               = var.tier
  memory_size_gb     = var.memory_size_gb
  authorized_network = var.authorized_network
}
