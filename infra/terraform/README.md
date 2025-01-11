## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.47.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_container_registry.docregistry](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/container_registry) | resource |
| [digitalocean_container_registry_docker_credentials.docr_credentials](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/container_registry_docker_credentials) | resource |
| [digitalocean_kubernetes_cluster.doks](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster) | resource |
| [digitalocean_vpc.doks_vpc](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/vpc) | resource |
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_scale"></a> [auto\_scale](#input\_auto\_scale) | Enable auto-scaling for the node pool | `bool` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_cluster_tags"></a> [cluster\_tags](#input\_cluster\_tags) | Tags for the Kubernetes cluster | `list(string)` | n/a | yes |
| <a name="input_do_token"></a> [do\_token](#input\_do\_token) | DigitalOcean API token | `string` | n/a | yes |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | Kubernetes version | `string` | n/a | yes |
| <a name="input_max_nodes"></a> [max\_nodes](#input\_max\_nodes) | Maximum number of nodes in the node pool | `number` | n/a | yes |
| <a name="input_min_nodes"></a> [min\_nodes](#input\_min\_nodes) | Minimum number of nodes in the node pool | `number` | n/a | yes |
| <a name="input_node_pool_name"></a> [node\_pool\_name](#input\_node\_pool\_name) | Name for the node pool | `string` | n/a | yes |
| <a name="input_node_pool_tags"></a> [node\_pool\_tags](#input\_node\_pool\_tags) | Tags for the node pool | `list(string)` | n/a | yes |
| <a name="input_node_size"></a> [node\_size](#input\_node\_size) | Size of the nodes | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region where the cluster will be created | `string` | n/a | yes |
| <a name="input_registry_name"></a> [registry\_name](#input\_registry\_name) | Name of the container registry | `string` | n/a | yes |
| <a name="input_subscription_tier_slug"></a> [subscription\_tier\_slug](#input\_subscription\_tier\_slug) | Subscription tier slug for the container registry | `string` | n/a | yes |
| <a name="input_vpc_ip_range"></a> [vpc\_ip\_range](#input\_vpc\_ip\_range) | IP range for the VPC | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint do cluster Kubernetes |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | ID do cluster Kubernetes |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | Status atual do cluster |
| <a name="output_kubeconfig_path"></a> [kubeconfig\_path](#output\_kubeconfig\_path) | Caminho do arquivo kubeconfig |
| <a name="output_kubernetes_version"></a> [kubernetes\_version](#output\_kubernetes\_version) | Versão do Kubernetes em uso |
| <a name="output_node_count"></a> [node\_count](#output\_node\_count) | Número atual de nodes no cluster |
| <a name="output_node_pool_id"></a> [node\_pool\_id](#output\_node\_pool\_id) | ID do node pool |
| <a name="output_registry_endpoint"></a> [registry\_endpoint](#output\_registry\_endpoint) | Endpoint do registry de containers |
| <a name="output_registry_name"></a> [registry\_name](#output\_registry\_name) | Nome do registry |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID da VPC |
| <a name="output_vpc_ip_range"></a> [vpc\_ip\_range](#output\_vpc\_ip\_range) | Range de IP da VPC |
