# general
variable "project_id" {
  type = string
}

variable "defualt_region" {
  type    = string
  default = "us-central1"
}

variable "defualt_zone" {
  type    = string
  default = "us-central1-a"
}

variable "environment" {
  type    = string
  default = "dev_CI"
}

