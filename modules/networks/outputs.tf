output "linux_network_id" {
  value = libvirt_network.infra_network.id
}

output "backend_linux_network_address" {
  value = libvirt_network.infra_network.addresses[0]
}
