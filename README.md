<h1 align="center">Projeto de fluxo contínuo, com Argo CD.</h1>

<div align="center">
<img src="assets/banner2.png"/>
</div>

<br>

<div align="center">

[![Workflow](https://img.shields.io/github/actions/workflow/status/dellabeneta/project-argocd/build-deploy.yaml?color=success&label=Workflow&logo=githubactions)](https://github.com/dellabeneta/project-argocd/actions)
[![Version](https://img.shields.io/badge/Version-1.0.0-blue?logo=github)](https://github.com/dellabeneta/project-argocd/releases) [![License](https://img.shields.io/github/license/dellabeneta/project-argocd?label=License&color=blue&logo=opensourceinitiative)](https://github.com/dellabeneta/project-argocd/blob/main/LICENSE) [![Infrastructure](https://img.shields.io/badge/Infrastructure-Terraform-blue?logo=terraform)](https://github.com/dellabeneta/project-argocd/tree/main/infra/terraform) 
[![Kubernetes](https://img.shields.io/badge/Kubernetes-ready-brightgreen?logo=kubernetes)](https://kubernetes.io/docs/) [![Argo CD](https://img.shields.io/badge/Argo--CD-ready-brightgreen?logo=argo)](https://argo-cd.readthedocs.io/)
</div>
<br>

<div align="justify">
Com um repositório GitHub bem estruturado, contendo pastas específicas para a aplicação, arquivos Terraform para provisionamento de infraestrutura, e manifests Kubernetes, é possível implementar um fluxo totalmente automatizado: do commit no código-fonte ao deploy da aplicação em um cluster Kubernetes.
<p><p>
O processo funciona conectando diferentes tecnologias. Sempre que houver alterações no código-fonte, um workflow gera automaticamente uma nova imagem Docker da aplicação. Em seguida, esse mesmo workflow atualiza o manifesto Kubernetes correspondente, armazenado na pasta designada. O ArgoCD, por sua vez, detecta essa atualização no manifesto e sincroniza a nova versão da aplicação no cluster, criando um fluxo contínuo e confiável de deploy automatizado.
</div>

#### Observações Gerais:

##### O projeto utiliza a Digital Ocean como IaaS, com IaC em Terraform que provisiona um Custer Kubernetes gerenciado (DOKS) com:

  - Integração nativa com registro de containers
  - Node Pool com auto-scaling configurado
  - VPC dedicada para isolamento de rede

##### Utilizei uma aplicação Python/Flask, by ChatGPT, para termos algo a ser buildado pelo Workflow Github Actions, que: 

  - Roda na porta 8080
  - Utiliza a imagem base `python:3.9-slim` para menor footprint
  - Expõe informações do hostname do pod + replicaset + deployment
  - Interface simples renderizada via template HTML

##### Argo CD: 

- **Sync Policy**: 
  - Automático com `selfHeal: true`
  - Prune habilitado para limpar recursos obsoletos
  - Criação automática de namespaces
- **Source**: 
  - Branch: HEAD (última versão)
  - Path: k8s/app
  - Monitoramento contínuo do repositório Git

#### Scripts de Automação ( quero reduzir ou abstraí-los ainda mais... )

O diretório `scripts/` contém utilitários essenciais:
1. `install-nginx-ingress.sh`: Configura o controlador de ingress
2. `install-cert-manager.sh`: Gerenciamento de certificados SSL/TLS
3. `install-argocd.sh`: Deploy do Argo CD
4. `install-kubeconfig.sh`: Configuração do acesso ao cluster

--

Muita melhoras ainda para serem feitas!
Trazer um HOW-TO... com passo a passo para subir tudo.
