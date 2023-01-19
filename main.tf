# Linode Provider definition
terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.29.4"
    }
  }
}

provider "linode" {
  token = var.linode_token
}

# Ensure Linodes Instances Exist.
resource "linode_instance" "linode-server" {
  count           = length(var.server_name)
  label           = var.server_name[count.index]
  image           = var.linode_image[count.index]
  tags            = var.linode_tags
  region          = var.linode_region
  type            = var.linode_type
  authorized_keys = [var.authorized_keys]
  #root_pass = "${var.linode_root_pass}"
  watchdog_enabled = "true"
}

output "linode_ip_addr" {
  value = linode_instance.linode-server[*].ip_address
}

