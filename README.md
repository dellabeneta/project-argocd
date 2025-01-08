https://drive.google.com/file/d/1QgjnmR5it1GI0S2VYD3Ysov_t3qD4ypY/view?usp=sharing

<img src="https://drive.google.com/uc?export=view&id=1QgjnmR5it1GI0S2VYD3Ysov_t3qD4ypY" width="1000">


## Meu projeto de fluxo contínuo, com Argo CD.


Com um repositório GitHub bem estruturado, contendo pastas específicas para a aplicação, arquivos Terraform para provisionamento de infraestrutura, e manifests Kubernetes, é possível implementar um fluxo totalmente automatizado: do commit no código-fonte ao deploy da aplicação em um cluster Kubernetes.

O processo funciona conectando diferentes tecnologias. Sempre que houver alterações no código-fonte, um workflow gera automaticamente uma nova imagem Docker da aplicação. Em seguida, esse mesmo workflow atualiza o manifesto Kubernetes correspondente, armazenado na pasta designada. O ArgoCD, por sua vez, detecta essa atualização no manifesto e sincroniza a nova versão da aplicação no cluster, criando um fluxo contínuo e confiável de deploy automatizado.
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
