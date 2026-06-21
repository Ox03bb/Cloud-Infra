variable "name" {
  type = string
}

variable "zone" {
  type = string
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}

variable "image" {
  type    = string
  default = "debian-cloud/debian-11"
}

variable "network" {
  type    = string
  default = "default"
}
variable "startup_script" {
  type    = string
  default = ""
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "network_interfaces" {
  type = list(object({
    network    = string
    subnetwork = string
    network_ip = optional(string)
  }))
}

variable "is_public" { # if the VM should have a public IP address
  type    = bool
  default = false
}
