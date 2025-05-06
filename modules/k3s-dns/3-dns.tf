resource "cloudflare_dns_record" "this" {
  for_each = var.hostname_ip_map

  zone_id = data.cloudflare_zone.this.zone_id
  type    = "A"
  proxied = false

  name    = var.subdomain != "" ? "${each.key}.${var.subdomain}" : "${each.key}"
  content = each.value
  comment = "k3s DNS entry managed by terraform"
  ttl     = 3600
}
