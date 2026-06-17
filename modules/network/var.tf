# VPC variables
variable "vpc_name" {
  type = string
}

# subnet variables
variable "subnet_name" {
  type    = string
  default = ""
}

variable "subnets" {
  type = map(object({
    cidr   = string
    region = string
  }))
}


# firewall variables
variable "firewall_allow" {
  type = list(object({
    protocol = string
    ports    = list(string)
  }))
  default = []
}

variable "firewall_source_ranges" {
  type    = list(string)
  default = []
}

variable "firewall_target_tags" {
  type    = list(string)
  default = []
}