# VPC variables
variable "vpc_name" {
  type = string
}

variable "is_public_vpc" {
  type    = bool
  default = false
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
variable "firewall_rules" {
  type = list(object({
    name           = optional(string)
    allow          = list(object({
      protocol = string
      ports    = list(string)
    }))
    source_ranges  = list(string)
    target_tags    = list(string)
  }))
  default = []
}