#!/bin/bash

# Criar namespace argocd
kubectl create namespace argocd

# Instalar ArgoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Aguardar pods do ArgoCD estarem prontos
echo "Aguardando pods do ArgoCD iniciarem..."
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=300s

# Aplicar configuração do Ingress
kubectl apply -f ../k8s/argocd/argocd-ingress.yaml

# Aplicar a configuração da aplicação
kubectl apply -f ../k8s/argocd/argocd-application.yaml

echo "Instalação concluída!"
echo "Você poderá acessar o ArgoCD em: https://argocd.dellabeneta.tech"
echo "Usuário: admin"
echo "Senha: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)"
