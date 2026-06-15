variable "name" {
    type = string
}

variable "zone" {
    type = string
}

variable "machine_type" {
    type = string
    default = "e2-micro"
}

variable "image" {
    type = string
    default = "debian-cloud/debian-11"
}

variable "network" {
    type = string
    default = "default"
}
variable "startup_script" {
    type = string
    default = ""
}

