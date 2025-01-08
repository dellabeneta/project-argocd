## Meu projeto de fluxo contínuo, com Argo CD.

<br>
<img src="assets/banner2.png"/>
<br>

Com um repositório GitHub bem estruturado, contendo pastas específicas para a aplicação, arquivos Terraform para provisionamento de infraestrutura, e manifests Kubernetes, é possível implementar um fluxo totalmente automatizado: do commit no código-fonte ao deploy da aplicação em um cluster Kubernetes.

O processo funciona conectando diferentes tecnologias. Sempre que houver alterações no código-fonte, um workflow gera automaticamente uma nova imagem Docker da aplicação. Em seguida, esse mesmo workflow atualiza o manifesto Kubernetes correspondente, armazenado na pasta designada. O ArgoCD, por sua vez, detecta essa atualização no manifesto e sincroniza a nova versão da aplicação no cluster, criando um fluxo contínuo e confiável de deploy automatizado.

## Requisitos do Projeto

Antes de começar, certifique-se de ter instalado:

- Docker
- Kubernetes cluster (local ou na nuvem)
- kubectl
- Terraform >= 1.0
- Git
- Conta no GitHub
- Conta no Docker Hub (ou outro registro de containers)

## Configuração do Ambiente

### 1. Configuração da Infraestrutura

```bash
cd infra/terraform
terraform init
terraform plan
terraform apply
```

### 2. Instalação das Dependências do Cluster

Os scripts necessários estão disponíveis no diretório `scripts/`:

```bash
# Instalar Nginx Ingress Controller
./scripts/install-nginx-ingress.sh

# Instalar Cert Manager para SSL/TLS
./scripts/install-cert-manager.sh

# Instalar Argo CD
./scripts/install-argocd.sh

# Configurar kubeconfig
./scripts/install-kubeconfig.sh
```

### 3. Configuração do Argo CD

1. Acesse o Argo CD UI através do ingress configurado
2. Faça login com as credenciais padrão
3. Configure o repositório Git
4. Aplique o arquivo de configuração da aplicação:
```bash
kubectl apply -f k8s/argocd/argocd-application.yaml
```

## Estrutura da Aplicação

### Aplicação Flask (`app/`)
- Aplicação web simples em Python/Flask
- Dockerfile otimizado para produção
- Requirements.txt com dependências fixas

### Infraestrutura (`infra/`)
- Configuração Terraform para Digital Ocean
- Provisionamento automatizado de:
  - Kubernetes cluster (DOKS)
  - Container Registry
  - Rede e recursos relacionados

### Kubernetes (`k8s/`)
- **app/**: Manifestos da aplicação
  - `deployment.yaml`: Configuração do deployment
  - `service.yaml`: Serviço Kubernetes
  - `ingress.yaml`: Configuração de ingress
- **argocd/**: Configurações do Argo CD
  - `argocd-application.yaml`: Definição da aplicação
  - `argocd-ingress.yaml`: Ingress do Argo CD

## CI/CD Pipeline

O pipeline de CI/CD é totalmente automatizado e consiste em:

1. **Continuous Integration**:
   - Testes automatizados
   - Build da imagem Docker
   - Push para o registro de containers

2. **Continuous Delivery**:
   - Atualização automática dos manifestos Kubernetes
   - Sincronização via Argo CD
   - Deploy automático no cluster

## Monitoramento e Logs

- A aplicação expõe métricas básicas via endpoint `/`
- Logs podem ser acessados via:
  ```bash
  kubectl logs -f -l app=flask-app
  ```

## Resolução de Problemas

### Problemas Comuns

1. **Falha na Sincronização do Argo CD**
   - Verifique as credenciais do repositório
   - Confirme se os manifestos são válidos
   - Verifique os logs do Argo CD

2. **Problemas no Deploy**
   - Verifique os logs da aplicação
   - Confirme se a imagem existe no registro
   - Verifique o status do pod:
     ```bash
     kubectl describe pod -l app=flask-app
     ```

## Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Crie um Pull Request

## Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## Contato e Suporte

Para reportar problemas ou sugerir melhorias, por favor abra uma issue no GitHub.

<br><br>
#### Aqui está uma estrutura resumida do projeto:
```
della@ubuntu:~/projetos/project-argocd$ tree -L 5
.
├── app
│   ├── Dockerfile
│   ├── requirements.txt
│   └── src
│       ├── app.py
│       └── templates
│           └── index.html
├── infra
│   └── terraform
│       ├── backend.tf
│       ├── doks.tf
│       ├── network.tf
│       ├── provider.tf
│       ├── registry.tf
│       ├── terraform.tfvars
│       └── variables.tf
├── k8s
│   ├── app
│   │   ├── deployment.yaml
│   │   ├── ingress.yaml
│   │   └── service.yaml
│   └── argocd
│       ├── argocd-application.yaml
│       └── argocd-ingress.yaml
├── LICENSE
├── README.md
└── scripts
    ├── install-argocd.sh
    ├── install-cert-manager.sh
    ├── install-kubeconfig.sh
    └── install-nginx-ingress.sh

10 directories, 22 files
```
<br>

#### Fluxo Resumido:

1. Desenvolvimento e Push no Código-fonte:
	- Você faz alterações no diretório app/ e dá push para o repositório.
2. GitHub Actions Aciona Workflow:
	- O workflow é acionado ao detectar mudanças em app/.
3. Ele:
    - Faz o build da imagem Docker.	    
	- Faz o push da imagem para o registro (ex.: Docker Hub).	    
	- Atualiza o Deployment.yaml no diretório k8s/ com a nova tag da imagem.
4. ArgoCD Observa Alterações:
	- O ArgoCD monitora a pasta k8s/.
	- Ao detectar o novo Deployment.yaml, ele sincroniza automaticamente com o cluster Kubernetes.
6. Cluster Atualizado:
    - A nova versão da aplicação é implantada no cluster Kubernetes.

<br><br>

#### Fluxo Visual:

**[app/]** → Alteração no código-fonte → Push para GitHub

**↓**

**[GitHub Actions Workflow]**:

- Build da imagem Docker

- Push da imagem para o registro (Docker Hub)

- Atualiza **[k8s/Deployment.yaml]**

**↓**

**[k8s/]** → ArgoCD monitora a pasta → Detecta mudanças

**↓**

ArgoCD sincroniza com o cluster Kubernetes → Nova versão online

<br>

---

<br>

**Essa estrutura e fluxo garantem uma integração limpa e automatizada entre desenvolvimento, CI/CD e o cluster Kubernetes.**
