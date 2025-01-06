variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "region" {
  description = "Region where the cluster will be created"
  type        = string
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
}

variable "node_size" {
  description = "Size of the nodes"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_ip_range" {
  description = "IP range for the VPC"
  type        = string
}

variable "cluster_tags" {
  description = "Tags for the Kubernetes cluster"
  type        = list(string)
}

variable "node_pool_tags" {
  description = "Tags for the node pool"
  type        = list(string)
}

variable "node_pool_name" {
  description = "Name for the node pool"
  type        = string
}

variable "auto_scale" {
  description = "Enable auto-scaling for the node pool"
  type        = bool
}

variable "min_nodes" {
  description = "Minimum number of nodes in the node pool"
  type        = number
}

variable "max_nodes" {
  description = "Maximum number of nodes in the node pool"
  type        = number
}

variable "registry_name" {
  description = "Name of the container registry"
  type        = string
}

variable "subscription_tier_slug" {
  description = "Subscription tier slug for the container registry"
  type        = string
}