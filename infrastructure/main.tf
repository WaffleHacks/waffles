terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "2.24.0"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.10.1"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

provider "digitalocean" {
  token = var.digitalocean_token
}
