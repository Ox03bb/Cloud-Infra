variable "vpc_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "subnets" {
  type = map(object({
    cidr   = string
    region = string
  }))
}