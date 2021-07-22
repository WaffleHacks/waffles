/*
  Providers
*/
variable "digitalocean_token" {
  type = string
  description = "The token used to authenticate with the DigitalOcean API"
  sensitive = true
}

variable "cloudflare_token" {
  type = string
  description = "The token used to authenticate with the Cloudflare API"
  sensitive = true
}

/*
  Existing resources
*/
variable "domain" {
  type = string
  description = "The domain to modify DNS records on, must be active on Cloudflare"
}

variable "project" {
  type = string
  description = "The DigitalOcean project to add resources to"
}

variable "ssh_key" {
  type = string
  description = "The DigitalOcean SSH key to add to the server"
}

/*
  Server configuration
*/
variable "digitalocean_region" {
  type = string
  description = "Where the resources should be deployed"
}
