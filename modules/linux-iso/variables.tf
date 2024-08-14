# Environment variable
variable "env" {
  description = "The environment (dev, stage, prod)"
  default     = "dev"
  type        = string
}

variable "amount_servers" {
  description = "The numbers needed"
  type        = number
}

variable "private_subnet_mask_id" {
  type = string
}

variable "host_ip" {
  type = list(string)
}

variable "host_mac" {
  type = list(string)
}

variable "host_name" {
  type = string
}

variable "iso_name" {
  type = string
}

variable "user_data" {
  type = string
}

variable "memory" {
  type = string
}

variable "cpu" {
  type = number
}

variable "qcow_source" {
  type = string
}