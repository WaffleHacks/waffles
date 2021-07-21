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
