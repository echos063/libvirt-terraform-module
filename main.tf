# Networks creating
module "network_config_project_release-12" {
  env                  = var.env
  source               = "./modules/networks"
  backend_network_name = "${var.env}-qp-net"
  backend_bridge_name  = "${var.env}-br-qp-net"
  private_subnet_mask  = ["10.25.110.0/24"]
}

module "network_config_project-release-13" {
  env                  = var.env
  source               = "./modules/networks"
  backend_network_name = "${var.env}-13-net"
  backend_bridge_name  = "${var.env}-br-13-net"
  private_subnet_mask  = ["10.26.110.0/24"]
}

# Projects
module "project-app-server-release-12" {
  env                    = var.env
  source                 = "./modules/linux-iso"
  amount_servers         = 1
  iso_name               = "project-app-server"
  host_name              = "project-app-server"
  host_ip                = ["10.25.110.10"]
  host_mac               = ["52:54:00:25:11:c3"]
  user_data              = "./project-app-server/user-data.yml"
  qcow_source            = "/path/to/your/image.qcow2"
  memory                 = "2048"
  cpu                    = 2
  private_subnet_mask_id = module.network_config_project_release-12.linux_network_id
}

module "project-adm-server-release-12" {
  env                    = var.env
  source                 = "./modules/linux-iso"
  amount_servers         = 1
  iso_name               = "project-adm-server"
  host_name              = "project-adm-server"
  host_ip                = ["10.25.110.11"]
  host_mac               = ["52:54:00:f4:11:c3"]
  user_data              = "./project-adm-server/user-data.yml"
  qcow_source            = "/path/to/your/image.qcow2"
  memory                 = "2048"
  cpu                    = 2
  private_subnet_mask_id = module.network_config_project_release-12.linux_network_id
}

module "project-app-server-release-13" {
  env                    = var.env
  source                 = "./modules/linux-iso"
  amount_servers         = 1
  iso_name               = "project-app-server-release-13"
  host_name              = "project-app-server-release-13"
  host_ip                = ["10.26.110.10"]
  host_mac               = ["52:54:00:f7:12:d3"]
  user_data              = "./project-app-server/user-data.yml"
  qcow_source            = "/path/to/your/image.qcow2"
  memory                 = "2048"
  cpu                    = 2
  private_subnet_mask_id = module.network_config_project-release-13.linux_network_id
}

module "project-adm-server-release-13" {
  env                    = var.env
  source                 = "./modules/linux-iso"
  amount_servers         = 1
  iso_name               = "project-adm-server-release-13"
  host_name              = "project-adm-server-release-13"
  host_ip                = ["10.26.110.11"]
  host_mac               = ["52:54:00:d7:d8:13"]
  user_data              = "./project-adm-server/user-data.yml"
  qcow_source            = "/path/to/your/image.qcow2"
  memory                 = "2048"
  cpu                    = 2
  private_subnet_mask_id = module.network_config_project-release-13.linux_network_id
}
