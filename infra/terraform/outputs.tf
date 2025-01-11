# Cluster Outputs
output "cluster_id" {
  description = "ID do cluster Kubernetes"
  value       = digitalocean_kubernetes_cluster.doks.id
}

output "cluster_endpoint" {
  description = "Endpoint do cluster Kubernetes"
  value       = digitalocean_kubernetes_cluster.doks.endpoint
  sensitive   = true
}

output "cluster_status" {
  description = "Status atual do cluster"
  value       = digitalocean_kubernetes_cluster.doks.status
}

output "kubernetes_version" {
  description = "Versão do Kubernetes em uso"
  value       = digitalocean_kubernetes_cluster.doks.version
}

# Node Pool Outputs
output "node_pool_id" {
  description = "ID do node pool"
  value       = digitalocean_kubernetes_cluster.doks.node_pool[0].id
}

output "node_count" {
  description = "Número atual de nodes no cluster"
  value       = digitalocean_kubernetes_cluster.doks.node_pool[0].actual_node_count
}

# VPC Outputs
output "vpc_id" {
  description = "ID da VPC"
  value       = digitalocean_vpc.doks_vpc.id
}

output "vpc_ip_range" {
  description = "Range de IP da VPC"
  value       = digitalocean_vpc.doks_vpc.ip_range
}

# Registry Outputs
output "registry_endpoint" {
  description = "Endpoint do registry de containers"
  value       = digitalocean_container_registry.docregistry.server_url
}

output "registry_name" {
  description = "Nome do registry"
  value       = digitalocean_container_registry.docregistry.name
}

# Kubeconfig
output "kubeconfig_path" {
  description = "Caminho do arquivo kubeconfig"
  value       = local_file.kubeconfig.filename
}