/*
  Providers
*/
variable "aws_access_key" {
  type        = string
  description = "The AWS access key ID to authenticate with"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "The AWS secret access key to authenticate with"
  sensitive   = true
}

variable "digitalocean_token" {
  type        = string
  description = "The token used to authenticate with the DigitalOcean API"
  sensitive   = true
}

variable "cloudflare_token" {
  type        = string
  description = "The token used to authenticate with the Cloudflare API"
  sensitive   = true
}

/*
  Existing resources
*/
variable "domain" {
  type        = string
  description = "The domain to modify DNS records on, must be active on Cloudflare"
  default     = "wafflehacks.org"
}

variable "project" {
  type        = string
  description = "The DigitalOcean project to add resources to"
  default     = "WaffleHacks"
}

variable "ssh_key" {
  type        = string
  description = "The DigitalOcean SSH key to add to the server"
  default     = "root@wafflehacks.tech"
}

/*
  Server configuration
*/
variable "regions" {
  type = object({
    aws          = string
    digitalocean = string
  })
  description = "Where the resources should be deployed per cloud provider"
  default = {
    aws          = "us-west-1"
    digitalocean = "sfo2"
  }
}
