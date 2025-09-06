#!/bin/bash
# copy-secret.sh
# Usage: ./copy-secret.sh <ns-from> <ns-to> <secret-name>

set -e

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <ns-from> <ns-to> <secret-name>"
  exit 1
fi

NS_FROM=$1
NS_TO=$2
SECRET=$3

echo "Copying secret '$SECRET' from namespace '$NS_FROM' to '$NS_TO'..."

kubectl get secret "$SECRET" -n "$NS_FROM" -o yaml \
  | sed "s/namespace: $NS_FROM/namespace: $NS_TO/" \
  | kubectl apply -n "$NS_TO" -f -

exit 0
