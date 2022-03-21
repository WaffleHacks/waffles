locals {
  // Get all the v4 and v6 addresses of the servers that should be routable
  routable_servers = [digitalocean_droplet.primary]
  ipv4             = { for server in local.routable_servers : server.name => server.ipv4_address }
  ipv6             = { for server in local.routable_servers : server.name => server.ipv6_address }

  // Setup the records to create
  parsed_records = yamldecode(data.local_file.dns_records.content)
  records = flatten(
    [for name, records in local.parsed_records :
      [for record in records : [
        { name = record, type = "A", value = local.ipv4[name] },
        { name = record, type = "AAAA", value = local.ipv6[name] }
        ]
      ]
    ]
  )
}

// Create all the specified records
resource "cloudflare_record" "record" {
  count = length(local.records)

  zone_id = data.cloudflare_zones.domain.zones[0].id

  type  = element(local.records, count.index)["type"]
  name  = element(local.records, count.index)["name"]
  value = element(local.records, count.index)["value"]

  ttl     = 1
  proxied = true
}

// Other DNS records, not pointed to our servers
resource "cloudflare_record" "instatus_page" {
  zone_id = data.cloudflare_zones.domain.zones[0].id

  type  = "CNAME"
  name  = "status.${var.domain}"
  value = "cname.instatus.com"

  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "mailgun_tracking" {
  zone_id = data.cloudflare_zones.domain.zones[0].id

  type  = "CNAME"
  name  = "email.${var.domain}"
  value = "mailgun.org"

  ttl     = 1
  proxied = true
}

// Define page rules
resource "cloudflare_page_rule" "mailgun_tracking" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  target  = "email.${var.domain}/*"

  actions {
    ssl = "flexible"
  }
}

resource "cloudflare_page_rule" "homepage_forwarding" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  target  = "www.${var.domain}/"

  actions {
    forwarding_url {
      url         = "https://${var.domain}"
      status_code = 301
    }
  }
}
