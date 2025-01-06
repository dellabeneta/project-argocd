resource "digitalocean_container_registry" "docregistry" {
  name                   = var.registry_name
  region                 = var.region
  subscription_tier_slug = var.subscription_tier_slug
}