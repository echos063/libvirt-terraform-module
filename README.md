# Repository for Local Server Provisioning with Terraform without AWS/GCP
This repository is intended for automating server configuration using Terraform.

### Installation Steps
1. Create a directory for the new server in the root directory
2. Create and populate the `user-data.yml` file for your server
3. Copy network and server templates in the root `main.tf` file
4. Add output information in the `outputs.tf` file
5. Run the commands `terraform init`, `terraform plan`, and `terraform apply` on the executing server.

By default, a namespace is created for the `dev-*`. environment. To create a separate environment, use the command (for example):


```shell
terraform apply -var="env=stage"
```

### Example Templates in the root `main.tf` file:

1. Network Creation Template

```shell
module "network_config_template" {
  env             = var.env
  source          = "./modules/networks"
 ### Set the network name
  backend_network_name    = "${var.env}-tt-net"
 ### Set the bridge name
  backend_bridge_name     = "${var.env}-br-tt-net"
 ### Set the subnet to be created
  private_subnet_mask     = ["10.30.110.0/24"]
}
```

2. Server Creation Template

```shell
module "linux-template" {
  env = var.env
  source = "./modules/linux-iso"
  ### Set the number of servers to be created
  amount_servers = 3
  ### Set the name of the ISO image to be created
  iso_name = "created-iso-name"
  ### Set the hostname of the server
  host_name = "server-hostname"
  ### Set the IP address for each VM (specified in quotes, separated by commas)
  host_ip = ["10.30.110.100", "10.30.110.101", "10.30.110.102"]
  ### Set the MAC address for each VM (to be specified in quotes, separated by commas). It is necessary to specify it for recreating the virtual machine using the 'amount_servers' variable with the same IP address.
  host_mac = ["52:54:18:df:15:44", "52:54:18:df:16:45", "52:54:18:df:17:46"]
  ### Specify the path to the `user-data.yml` configuration
  user_data = "./path/to/your/user-data.yml"
  ### Specify the path to the `qcow2` image on the server
  qcow_source = "/path/to/your/image.qcow2"
  ### Specify the amount of RAM
  memory = "2048"
  ### Specify the number of CPUs
  cpu = 2
  private_subnet_mask_id = module.network_config_template.backend_linux_network_id
}
```

### Description of this repository
This repository is designed to work with the Linux image specified in the `qcow_source` line.

All operations are based on two modules.

### 1. Module for Linux Image
Path: `modules/linux-iso`

Main files:

- `modules/linux-iso/main.tf`: Describes the resources to be created, with data taken from input variables defined in the `main.tf` file located at the root of the repository.
- `modules/linux-iso/outputs.tf`: Passes variables from the `modules/networks` module to the `modules/linux-iso` module.
- `modules/linux-iso/providers.tf`: Describes the connection to the host for creating the virtual machine (VM).
- `modules/linux-iso/variables.tf`: Stores the variables accepted by the `modules/linux-iso/main.tf` file. The variable values are sourced from the root `main.tf`.
### 2. Module for Network Configuration
Path: `modules/networks`

Main files:

- `modules/networks/main.tf`: Describes the network resources to be created, with data taken from input variables defined in the `main.tf` file located at the root of the repository.
- `modules/networks/outputs.tf`: Passes variables from the `modules/networks module`.
- `modules/networks/providers.tf`: Describes the connection to the host for creating network resources.
- `modules/networks/variables.tf`: Stores the variables accepted by the `modules/linux-iso/main.tf` file and the root `main.tf`. The variable values are sourced from the root `main.tf`.

Each module describes the behavior of creating VMs using KVM, taking input parameters described in the template examples. All fields marked with `###` are mandatory and must be unique.

The modules are invoked through the main control file `main.tf`, located in the root of the repository.