#!/bin/bash

# Criar namespace
kubectl create namespace ingress-nginx

# Adicionar e atualizar o repo do helm
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Instalar nginx-ingress via helm
helm install nginx-ingress ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.publishService.enabled=true

# Aguardar o LoadBalancer estar pronto
echo "Aguardando LoadBalancer ser provisionado..."
while [ -z "$(kubectl get svc nginx-ingress-ingress-nginx-controller -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')" ]; do
   sleep 5
   echo "Ainda aguardando IP do LoadBalancer..."
done

# Mostrar o IP externo
echo "LoadBalancer provisionado!"
echo "IP Externo: $(kubectl get svc nginx-ingress-ingress-nginx-controller -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')"
echo ""
echo "Configure seu DNS:"
echo "argocd.dellabeneta.tech -> $(kubectl get svc nginx-ingress-ingress-nginx-controller -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')"
