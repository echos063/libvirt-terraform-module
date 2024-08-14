resource "libvirt_network" "infra_network" {
  name      = var.backend_network_name
  bridge    = var.backend_bridge_name
  domain    = var.backend_domain
  autostart = true
  mode      = "nat"
  addresses = var.private_subnet_mask

  dns {
    enabled    = true
    local_only = true
  }
}