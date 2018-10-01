variable "product_name" {
  default = "consul"
}
variable "client_role" {
  default = "client"
}
variable "server_role" {
  default = "server"
}
variable "ui_role" {
  default = "ui"
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

resource "digitalocean_tag" "ui_role" {
  name = "${var.ui_role}"
}

resource "digitalocean_tag" "server_role" {
  name = "${var.server_role}"
}

variable "service_name" {
  default = "consuldemo"
}

resource "digitalocean_tag" "service_name" {
  name = "${var.service_name}"
}

resource "digitalocean_droplet" "ui_droplet" {
  image = "ubuntu-18-04-x64"
  name = "${var.product_name}-${var.ui_role}"
  region = "fra1"
  size = "2gb"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.target_env.name}","${digitalocean_tag.product_name.name}","${digitalocean_tag.client_role.name}","${digitalocean_tag.ui_role.name}"]
}

resource "ansible_host" "ui_droplet" {
    inventory_hostname = "${digitalocean_droplet.ui_droplet.ipv4_address}"
    groups = ["${var.target_env}","${var.product_name}","${var.client_role}","${var.ui_role}"]
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
  tags = ["${digitalocean_tag.target_env.name}","${digitalocean_tag.product_name.name}","${digitalocean_tag.server_role.name}"]
}

resource "ansible_host" "server_01_droplet" {
    inventory_hostname = "${digitalocean_droplet.server_01_droplet.ipv4_address}"
    groups = ["${var.target_env}","${var.product_name}","${var.server_role}"]
    vars {
      ansible_python_interpreter = "/usr/bin/python3"
    }
}

resource "digitalocean_droplet" "server_02_droplet" {
  image = "ubuntu-18-04-x64"
  name = "${var.product_name}-${var.server_role}-02"
  region = "fra1"
  size = "2gb"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.target_env.name}","${digitalocean_tag.product_name.name}","${digitalocean_tag.server_role.name}"]
}

resource "ansible_host" "server_02_droplet" {
    inventory_hostname = "${digitalocean_droplet.server_02_droplet.ipv4_address}"
    groups = ["${var.target_env}","${var.product_name}","${var.server_role}"]
    vars {
      ansible_python_interpreter = "/usr/bin/python3"
    }
}

resource "digitalocean_droplet" "server_03_droplet" {
  image = "ubuntu-18-04-x64"
  name = "${var.product_name}-${var.server_role}-03"
  region = "fra1"
  size = "2gb"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.target_env.name}","${digitalocean_tag.product_name.name}","${digitalocean_tag.server_role.name}"]
}

resource "ansible_host" "server_03_droplet" {
    inventory_hostname = "${digitalocean_droplet.server_03_droplet.ipv4_address}"
    groups = ["${var.target_env}","${var.product_name}","${var.server_role}"]
    vars {
      ansible_python_interpreter = "/usr/bin/python3"
    }
}

resource "digitalocean_droplet" "service_01_droplet" {
  image = "ubuntu-18-04-x64"
  name = "${var.service_name}-01"
  region = "fra1"
  size = "2gb"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.target_env.name}","${digitalocean_tag.product_name.name}","${digitalocean_tag.client_role.name}","${digitalocean_tag.service_name.name}"]
}

resource "ansible_host" "service_01_droplet" {
    inventory_hostname = "${digitalocean_droplet.service_01_droplet.ipv4_address}"
    groups = ["${var.target_env}","${var.product_name}","${var.client_role}","${var.service_name}"]
    vars {
      ansible_python_interpreter = "/usr/bin/python3"
    }
}

resource "digitalocean_droplet" "service_02_droplet" {
  image = "ubuntu-18-04-x64"
  name = "${var.service_name}-02"
  region = "fra1"
  size = "2gb"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.target_env.name}","${digitalocean_tag.product_name.name}","${digitalocean_tag.client_role.name}","${digitalocean_tag.service_name.name}"]
}

resource "ansible_host" "service_02_droplet" {
    inventory_hostname = "${digitalocean_droplet.service_02_droplet.ipv4_address}"
    groups = ["${var.target_env}","${var.product_name}","${var.client_role}","${var.service_name}"]
    vars {
      ansible_python_interpreter = "/usr/bin/python3"
    }
}
