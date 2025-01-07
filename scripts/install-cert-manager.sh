#!/bin/bash

# Instalar cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.3/cert-manager.yaml

# Aguardar pods do cert-manager estarem prontos
echo "Aguardando pods do cert-manager iniciarem..."
kubectl wait --for=condition=Ready pods --all -n cert-manager --timeout=300s

# Criar ClusterIssuer para Let's Encrypt
cat << 'EOF' | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: m.dellabeneta@gmail.com
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: nginx
EOF

echo "Cert-manager instalado com sucesso!"
