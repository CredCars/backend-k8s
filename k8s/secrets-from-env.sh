#!/usr/bin/env bash
# usage: ./k8s/secrets-from-env.sh <namespace> <env-file>
NAMESPACE=$1
ENV_FILE=$2
SECRET_NAME=${3:-credcars-backend-secrets}

if [ -z "$NAMESPACE" ] || [ -z "$ENV_FILE" ]; then
  echo "Usage: $0 <namespace> <env-file>"
  exit 1
fi

kubectl -n "$NAMESPACE" delete secret "$SECRET_NAME" --ignore-not-found
kubectl -n "$NAMESPACE" create secret generic "$SECRET_NAME" --from-env-file="$ENV_FILE"
echo "✅ Secret '$SECRET_NAME' created in namespace '$NAMESPACE'"
