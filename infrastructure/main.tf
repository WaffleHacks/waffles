terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.50.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.24.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.10.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.regions.aws
  default_tags {
    tags = {
      project = "wafflehacks"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

provider "digitalocean" {
  token = var.digitalocean_token
}
