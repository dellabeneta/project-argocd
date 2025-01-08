#!/bin/bash

# Instalar o metrics-server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
echo "Metrics-server instalado com sucesso!"