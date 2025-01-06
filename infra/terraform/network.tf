resource "digitalocean_vpc" "doks_vpc" {
  name     = var.vpc_name
  region   = var.region
  ip_range = var.vpc_ip_range
}