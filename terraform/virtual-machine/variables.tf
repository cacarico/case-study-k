variable "name" {
  description = "Name for all resources"
  type = string
  default = "web-server"
}

variable "machine_type" {
  description = "Instance type"
  type = string
  default = "e2-micro"
}

variable "image" {
  description = "Image name for the instance"
  type = string
  default = "centos-cloud/centos-7"
}

variable "zone" {
  description = "Zone to deploy the instance"
  type = string
  default = "europe-west3-a"
}

variable "network" {
  description = "Network name"
  type = string
  default = "default"
}

variable "ssh_ip" {
    description = "The ip that is enabled to ss"
    type = string
    default = "0.0.0.0/0"
}

variable "disk_size" {
    description = "The disk size for the instance"
    type = number
    default = 20
}
