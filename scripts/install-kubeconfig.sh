#!/bin/bash

# Move o arquivo kubeconfig baixadopelo terraform para a pasta ~/.kube/
mv /home/della/projetos/project-argocd/infra/terraform/kubeconfig* ~/.kube/config
echo "Arquivo kubeconfig movido com sucesso!"