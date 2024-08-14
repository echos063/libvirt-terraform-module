# Environment variable
variable "env" {
  description = "The environment (dev, stage, prod)"
  default     = "dev"
  type        = string
}

variable "backend_network_name" {
  description = "The name of the network"
  type        = string
}

variable "backend_bridge_name" {
  description = "The name of the bridge"
  type        = string
}

variable "backend_domain" {
  default = "backend.psbcp.local"
  type    = string
}

variable "private_subnet_mask" {
  description = "The subnet mask for the network"
  type        = list(string)
}