data "template_file" "user_data_linux-iso" {
  template = file(var.user_data)
}

resource "libvirt_cloudinit_disk" "cloudinit_linux-iso" {
  count     = var.amount_servers
  name      = "${var.env}-${var.iso_name}${count.index}.iso"
  user_data = data.template_file.user_data_linux-iso.rendered
  pool      = "default"
}

resource "libvirt_volume" "linux-iso-volume" {
  count  = var.amount_servers
  name   = "${var.env}-${var.iso_name}${count.index}-volume"
  pool   = "default"
  source = var.qcow_source
  format = "qcow2"
}

resource "libvirt_domain" "linux-iso" {
  count  = var.amount_servers
  name   = "${var.env}-${var.iso_name}${count.index}"
  memory = var.memory
  vcpu   = var.cpu

  cloudinit = libvirt_cloudinit_disk.cloudinit_linux-iso[count.index].id

  network_interface {
    network_id     = var.private_subnet_mask_id
    hostname       = "${var.env}-${var.host_name}${count.index}"
    addresses      = [var.host_ip[count.index]]
    mac            = var.host_mac[count.index]
    wait_for_lease = true
  }
  disk {
    volume_id = "${libvirt_volume.linux-iso-volume[count.index].id}"
  }
  boot_device {
    dev = ["hd"]
  }
  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
  graphics {
    type        = "vnc"
    listen_type = "address"
    autoport    = true
  }
  timeouts {
    create = "5m"
  }
}
