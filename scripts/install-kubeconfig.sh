#!/bin/bash

PROJECT_PATH=$(pwd)

mv "$PROJECT_PATH/infra/terraform/kubeconfig" ~/.kube/config

chmod 600 ~/.kube/config

echo "Arquivo kubeconfig movido para ~/.kube/config com sucesso."