## Meu projeto de fluxo contínuo, com Argo CD.

Com um repositório GitHub bem estruturado, contendo pastas específicas para a aplicação, arquivos Terraform para provisionamento de infraestrutura, e manifests Kubernetes, é possível implementar um fluxo totalmente automatizado: do commit no código-fonte ao deploy da aplicação em um cluster Kubernetes.

O processo funciona conectando diferentes tecnologias. Sempre que houver alterações no código-fonte, um workflow gera automaticamente uma nova imagem Docker da aplicação. Em seguida, esse mesmo workflow atualiza o manifesto Kubernetes correspondente, armazenado na pasta designada. O ArgoCD, por sua vez, detecta essa atualização no manifesto e sincroniza a nova versão da aplicação no cluster, criando um fluxo contínuo e confiável de deploy automatizado.
<br><br>
#### Aqui está uma estrutura resumida do projeto:

    meu-projeto/
    
    ├── app/ # Código-fonte da aplicação
    
    │ ├── src/
    
    │ ├── Dockerfile # Arquivo para build da imagem Docker
    
    │ └── ... # Outros arquivos do projeto
    
    ├── infra/
    
    │ └── terraform/ # Arquivos Terraform para infraestrutura
    
    │ ├── main.tf
    
    │ ├── variables.tf
    
    │ └── ...
    
    ├── k8s/ # Manifests do Kubernetes
    
    │ ├── Deployment.yaml # Define o deploy da aplicação
    
    │ ├── Service.yaml # Define o serviço (LB ou ClusterIP)
    
    │ └── ...
    
    └── .github/
    
    └── workflows/ # Workflows do GitHub Actions
    
    └── build-deploy.yaml # Workflow automatizado

<br><br>

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