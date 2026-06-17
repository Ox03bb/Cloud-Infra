variable "name" {
  type        = string
  description = "GCS bucket name"
}

variable "location" {
  type        = string
  description = "Bucket location"
  default     = "US"
}

variable "storage_class" {
  type        = string
  description = "Storage class"
  default     = "STANDARD"
}

variable "force_destroy" {
  type        = bool
  description = "Force destroy bucket with objects"
  default     = false
}
