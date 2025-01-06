#!/bin/bash

# Instalar ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Recuperar senha inicial
ARGO_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo "ArgoCD instalado com sucesso!"
echo "Usuário padrão: admin"
echo "Senha inicial: $ARGO_PASSWORD"

# Opcional: Criar aplicação
kubectl apply -f ../k8s/argocd-application.yaml
