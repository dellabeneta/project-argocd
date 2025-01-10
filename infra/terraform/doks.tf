resource "digitalocean_kubernetes_cluster" "doks" {
  name                 = var.cluster_name
  region               = var.region
  vpc_uuid             = digitalocean_vpc.doks_vpc.id
  version              = var.k8s_version
  tags                 = var.cluster_tags
  registry_integration = true

  node_pool {
    name       = var.node_pool_name
    size       = var.node_size
    tags       = var.node_pool_tags
    auto_scale = var.auto_scale
    min_nodes  = var.min_nodes
    max_nodes  = var.max_nodes
  }

  depends_on = [digitalocean_vpc.doks_vpc]
}

resource "digitalocean_container_registry_docker_credentials" "docr_credentials" {
  registry_name  = digitalocean_container_registry.docregistry.name
  expiry_seconds = 3600
  write          = true
}

resource "local_file" "kubeconfig" {
  content              = digitalocean_kubernetes_cluster.doks.kube_config[0].raw_config
  filename             = pathexpand("~/.kube/config")
  directory_permission = "0755"
  file_permission      = "0600"
}