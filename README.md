## Meu projeto de fluxo contínuo, com Argo CD. 🚀

<br>
<img src="assets/banner2.png"/>
<br>

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/dellabeneta/project-argocd/build-deploy.yaml?label=Deploy)
![GitHub top language](https://img.shields.io/github/languages/top/dellabeneta/project-argocd)

![Docker Pulls](https://img.shields.io/docker/pulls/dellabeneta/project-argocd/app)
![Docker Image Version](https://img.shields.io/docker/v/dellabeneta/python-peoples-crud-backend/latest)
![Terraform Version](https://img.shields.io/badge/Terraform-v1.10.1-blue)

![GitHub License](https://img.shields.io/github/license/dellabeneta/python-peoples-crud)

Com um repositório GitHub bem estruturado, contendo pastas específicas para a aplicação, arquivos Terraform para provisionamento de infraestrutura, e manifests Kubernetes, é possível implementar um fluxo totalmente automatizado: do commit no código-fonte ao deploy da aplicação em um cluster Kubernetes.

O processo funciona conectando diferentes tecnologias. Sempre que houver alterações no código-fonte, um workflow gera automaticamente uma nova imagem Docker da aplicação. Em seguida, esse mesmo workflow atualiza o manifesto Kubernetes correspondente, armazenado na pasta designada. O ArgoCD, por sua vez, detecta essa atualização no manifesto e sincroniza a nova versão da aplicação no cluster, criando um fluxo contínuo e confiável de deploy automatizado.

## Detalhamento Técnico do Projeto 🛠️

### Infraestrutura na Digital Ocean ☁️

O projeto utiliza a Digital Ocean como provedor de cloud, com uma configuração Terraform que provisiona:

> ⚠️ **Importante¹**: Antes de executar o Terraform, crie seu arquivo `terraform.tfvars` na pasta `infra/terraform/` com suas configurações específicas. O restante do código Terraform é genérico e reutilizável.

Exemplo de `terraform.tfvars`:
```hcl
do_token        = "seu_token_da_digital_ocean"
region          = "nycX"
cluster_name    = "seu-cluster"
k8s_version     = "1.29.X-do.X"
node_pool_name  = "worker-pool"
node_size       = "s-2vcpu-4gb"
min_nodes       = 1
max_nodes       = 5
```

- **Cluster Kubernetes (DOKS)** 🎯:
  - Versão personalizada do Kubernetes
  - Integração nativa com registro de containers
  - Node Pool com auto-scaling configurado (min: ${var.min_nodes}, max: ${var.max_nodes})
  - VPC dedicada para isolamento de rede

- **Container Registry** 📦:
  - Registro privado na Digital Ocean
  - Credenciais com expiração de 1 hora (3600 segundos)
  - Integração automática com o cluster DOKS

### Aplicação Flask 🐍

Uma aplicação web minimalista em Python que:
- Roda na porta 8080
- Utiliza a imagem base `python:3.9-slim` para menor footprint
- Expõe informações do hostname do pod
- Interface simples renderizada via template HTML

### Configuração Kubernetes ⚙️

#### Deployment
- **Escalabilidade**: 10 réplicas para alta disponibilidade
- **Imagem**: Hospedada no registro privado da Digital Ocean
- **Namespace**: default
- **Labels**: Consistentes para fácil identificação e seleção

#### Argo CD 🔄
- **Sync Policy**: 
  - Automático com `selfHeal: true`
  - Prune habilitado para limpar recursos obsoletos
  - Criação automática de namespaces
- **Source**: 
  - Branch: HEAD (última versão)
  - Path: k8s/app
  - Monitoramento contínuo do repositório Git

### Scripts de Automação 📜

O diretório `scripts/` contém utilitários essenciais:
1. `install-nginx-ingress.sh`: Configura o controlador de ingress
2. `install-cert-manager.sh`: Gerenciamento de certificados SSL/TLS
3. `install-argocd.sh`: Deploy do Argo CD
4. `install-kubeconfig.sh`: Configuração do acesso ao cluster

### Fluxo de Deploy Detalhado 🔄

1. **Provisionamento Inicial**:
   ```bash
   cd infra/terraform
   terraform init && terraform apply
   ```
   - Cria cluster DOKS
   - Configura registro de containers
   - Gera arquivo kubeconfig

2. **Configuração do Cluster**:

   >⚠️ **Importante²**: Tu vai conseguir se virar em localhost e algum emulador de cluster. Mas indico FORTEMENTE que você tenha um domínio e um DNS real.

   - Instalação do Nginx Ingress
   - Configuração do Cert Manager
   - Deploy do Argo CD

   > ⚠️ **Importante³**: O Cert Manager precisa que os DNS estejam propagados ao solicitar certificados reais, especialmente ao usar o desafio DNS-01 do Let's Encrypt. Embora seja possível instalar o Cert Manager antes da propagação dos DNS, a emissão dos certificados depende dessa propagação. Fique atento!

3. **Deploy da Aplicação**:
   - Push do código para o GitHub
   - Build automático da imagem
   - Update do manifesto Kubernetes
   - Sincronização via Argo CD

### Comandos Úteis 💻

**Verificar Status dos Pods**:
```bash
kubectl get pods -l app=podname
```

**Logs da Aplicação**:
```bash
kubectl logs -f -l app=podname
```

**Status do Argo CD**:
```bash
kubectl get applications -n argocd
```

### Arquitetura de Rede 🌐

- Aplicação exposta na porta 8080
- Ingress configurado para roteamento de tráfego
- VPC isolada na Digital Ocean
- Comunicação segura entre pods

### Próximos Passos e Melhorias 🎯

1. **Monitoramento**:
   - Implementar Prometheus para métricas
   - Configurar Grafana para visualização

2. **Segurança**:
   - Implementar Network Policies
   - Configurar SecurityContext nos pods
   - Adicionar scanning de vulnerabilidades

3. **Alta Disponibilidade**:
   - Configurar pod disruption budgets
   - Implementar health checks mais robustos
   - Adicionar estratégias de backup

---

<br>

**Essa estrutura e fluxo garantem uma integração limpa e automatizada entre desenvolvimento, CI/CD e o cluster Kubernetes.** 
