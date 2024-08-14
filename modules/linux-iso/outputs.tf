output "server_ip" {
  value = [for instance in libvirt_domain.linux-iso : instance.network_interface[0].addresses[0]]
}

output "server_mac" {
  value = [for instance in libvirt_domain.linux-iso : instance.network_interface[0].mac]
}
