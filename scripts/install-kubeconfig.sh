#!/bin/bash

# Move o arquivo kubeconfig baixado pelo terraform após o provisionamento, para a pasta ~/.kube/
mv /home/della/projetos/project-argocd/infra/terraform/kubeconfig* ~/.kube/config
chmod 600 ~/.kube/config
echo "Arquivo kubeconfig movido com sucesso!"