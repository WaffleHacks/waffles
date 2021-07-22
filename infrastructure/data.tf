data "cloudflare_zones" "domain" {
  filter {
    name = var.domain
    status = "active"
  }
}

data "digitalocean_project" "project" {
  name = var.project
}

data "digitalocean_ssh_key" "root" {
  name = var.ssh_key
}
