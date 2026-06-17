variable "name" {
  type        = string
  description = "Memorystore instance name"
}

variable "region" {
  type        = string
  description = "Region for the Memorystore instance"
  default     = "us-central1"
}

variable "tier" {
  type        = string
  description = "Redis tier (BASIC or STANDARD_HA)"
  default     = "BASIC"
}

variable "memory_size_gb" {
  type        = number
  description = "Memory size in GB"
  default     = 1
}

variable "authorized_network" {
  type        = string
  description = "VPC network self_link to authorize"
}
