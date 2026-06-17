variable "name" {
  type        = string
  description = "Cloud SQL instance name"
}

variable "region" {
  type        = string
  description = "Region for the Cloud SQL instance"
  default     = "us-central1"
}

variable "database_version" {
  type        = string
  description = "Database version (e.g., POSTGRES_14, MYSQL_8_0)"
  default     = "POSTGRES_14"
}

variable "tier" {
  type        = string
  description = "Instance machine type/tier"
  default     = "db-f1-micro"
}

variable "disk_size" {
  type        = number
  description = "Disk size in GB"
  default     = 10
}

variable "private_network" {
  type        = string
  description = "VPC network self_link for private IP configuration"
}
