variable "product_name" {
  default = "consul"
}
variable "client_role" {
  default = "client"
}
variable "server_role" {
  default = "server"
}
variable "bootstrap_role" {
  default = "bootstrap"
}

resource "digitalocean_tag" "product_name" {
  name = "${var.product_name}"
}
resource "digitalocean_tag" "target_env" {
  name = "${var.target_env}"
}

resource "digitalocean_tag" "client_role" {
  name = "${var.client_role}"
}

resource "digitalocean_tag" "server_role" {
  name = "${var.server_role}"
}

resource "digitalocean_tag" "bootstrap_role" {
  name = "${var.bootstrap_role}"
}

resource "digitalocean_droplet" "client_droplet" {
  image = "ubuntu-18-04-x64"
  name = "${var.product_name}-${var.client_role}"
  region = "fra1"
  size = "2gb"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.client_role.name}","${digitalocean_tag.product_name.name}","${digitalocean_tag.target_env.name}"]
}

resource "ansible_host" "client_droplet" {
    inventory_hostname = "${digitalocean_droplet.client_droplet.ipv4_address}"
    groups = ["${var.client_role}","${var.product_name}","${var.target_env}"]
    vars {
      ansible_python_interpreter = "/usr/bin/python3"
    }
}

resource "digitalocean_droplet" "server_01_droplet" {
  image = "ubuntu-18-04-x64"
  name = "${var.product_name}-${var.server_role}-01"
  region = "fra1"
  size = "2gb"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.bootstrap_role.name}","${digitalocean_tag.product_name.name}","${digitalocean_tag.target_env.name}"]
}

resource "ansible_host" "server_01_droplet" {
    inventory_hostname = "${digitalocean_droplet.server_01_droplet.ipv4_address}"
    groups = ["${var.server_role}","${var.bootstrap_role}","${var.product_name}","${var.target_env}"]
    vars {
      ansible_python_interpreter = "/usr/bin/python3"
#      consul_node_role = "${var.bootstrap_role}"
    }
}

resource "digitalocean_droplet" "server_02_droplet" {
  image = "ubuntu-18-04-x64"
  name = "${var.product_name}-${var.server_role}-02"
  region = "fra1"
  size = "2gb"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.server_role.name}","${digitalocean_tag.product_name.name}","${digitalocean_tag.target_env.name}"]
}

resource "ansible_host" "server_02_droplet" {
    inventory_hostname = "${digitalocean_droplet.server_02_droplet.ipv4_address}"
    groups = ["${var.server_role}","${var.product_name}","${var.target_env}"]
    vars {
      ansible_python_interpreter = "/usr/bin/python3"
#      consul_node_role = "${var.server_role}"
    }
}

resource "digitalocean_droplet" "server_03_droplet" {
  image = "ubuntu-18-04-x64"
  name = "${var.product_name}-${var.server_role}-03"
  region = "fra1"
  size = "2gb"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.server_role.name}","${digitalocean_tag.product_name.name}","${digitalocean_tag.target_env.name}"]
}

resource "ansible_host" "server_03_droplet" {
    inventory_hostname = "${digitalocean_droplet.server_03_droplet.ipv4_address}"
    groups = ["${var.server_role}","${var.product_name}","${var.target_env}"]
    vars {
      ansible_python_interpreter = "/usr/bin/python3"
#      consul_node_role = "${var.server_role}"
    }
}
