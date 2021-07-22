resource "digitalocean_vpc" "network" {
  name = "waffle-network"
  region = var.digitalocean_region
  ip_range = "10.93.35.0/24"
}

resource "digitalocean_droplet" "primary" {
  name = "waffle-primary"

  image = "debian-10-x64"
  size = "s-2vcpu-4gb"
  region = var.digitalocean_region

  ssh_keys = [ data.digitalocean_ssh_key.root.id ]

  ipv6 = true
  private_networking = true
  vpc_uuid = digitalocean_vpc.network.id
}

resource "digitalocean_firewall" "primary" {
  name = "waffle-firewall-primary"

  droplet_ids = [ digitalocean_droplet.primary.id ]

  dynamic "inbound_rule" {
    for_each = ["22", "80", "443"]

    content {
      protocol = "tcp"
      port_range = inbound_rule.value
      source_addresses = ["0.0.0.0/0", "::/0"]
    }
  }

  // TCP - Allow traffic to anywhere
  outbound_rule {
    protocol = "tcp"
    port_range = "1-65536"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  // UDP - Allow traffic to anywhere
  outbound_rule {
    protocol = "udp"
    port_range = "1-65536"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
