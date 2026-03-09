#!/bin/bash
set -e

# Fly Agile Games Homepage - Manual Scaleway Deployment
# For CI/CD, use .gitlab-ci.yml instead.
# Requires: .env with SCW_ACCESS_KEY, SCW_SECRET_KEY, SCW_DEFAULT_ORGANIZATION_ID, SCW_DEFAULT_PROJECT_ID

source .env

export SCW_ACCESS_KEY=${SCW_ACCESS_KEY}
export SCW_SECRET_KEY=${SCW_SECRET_KEY}
export SCW_DEFAULT_ORGANIZATION_ID=${SCW_DEFAULT_ORGANIZATION_ID}
export SCW_DEFAULT_PROJECT_ID=${SCW_DEFAULT_PROJECT_ID}

NAMESPACE_NAME="games-homepage"
IMAGE_NAME="games-homepage"
REGION="fr-par"
MEMORY_LIMIT=128

echo "Building Docker image..."
docker build -t ${IMAGE_NAME}:latest .

echo "Setting up Scaleway container namespace..."
scw container namespace create \
  name=${NAMESPACE_NAME} \
  region=${REGION} \
  project-id=${SCW_DEFAULT_PROJECT_ID} 2>/dev/null || echo "Namespace already exists"

CONTAINER_INFO=$(scw container namespace list region=${REGION} -o json | jq -r ".[] | select(.name==\"${NAMESPACE_NAME}\")")
CONTAINER_NAMESPACE_ID=$(echo "$CONTAINER_INFO" | jq -r ".id")
REGISTRY_ENDPOINT=$(echo "$CONTAINER_INFO" | jq -r ".registry_endpoint")

if [ -z "$CONTAINER_NAMESPACE_ID" ] || [ "$CONTAINER_NAMESPACE_ID" = "null" ]; then
  echo "Failed to get namespace ID"
  exit 1
fi

echo "Namespace ID: ${CONTAINER_NAMESPACE_ID}"
echo "Registry: ${REGISTRY_ENDPOINT}"

echo "Pushing to Scaleway registry..."
echo ${SCW_SECRET_KEY} | docker login rg.fr-par.scw.cloud -u nologin --password-stdin
docker tag ${IMAGE_NAME}:latest ${REGISTRY_ENDPOINT}/${IMAGE_NAME}:latest
docker push ${REGISTRY_ENDPOINT}/${IMAGE_NAME}:latest

echo "Deploying container..."
EXISTING=$(scw container container list namespace-id=${CONTAINER_NAMESPACE_ID} region=${REGION} -o json \
  | jq -r ".[] | select(.name==\"${IMAGE_NAME}\") | .id")

if [ -z "$EXISTING" ] || [ "$EXISTING" = "null" ]; then
  scw container container create \
    namespace-id=${CONTAINER_NAMESPACE_ID} \
    name=${IMAGE_NAME} \
    registry-image=${REGISTRY_ENDPOINT}/${IMAGE_NAME}:latest \
    port=80 \
    min-scale=0 \
    max-scale=5 \
    memory-limit=${MEMORY_LIMIT} \
    region=${REGION}
else
  scw container container update \
    container-id=${EXISTING} \
    registry-image=${REGISTRY_ENDPOINT}/${IMAGE_NAME}:latest \
    region=${REGION}
  scw container container deploy ${EXISTING} region=${REGION}
fi

CONTAINER_ID=$(scw container container list namespace-id=${CONTAINER_NAMESPACE_ID} region=${REGION} -o json \
  | jq -r ".[] | select(.name==\"${IMAGE_NAME}\") | .id")

echo ""
echo "Deployment complete!"
echo "Container ID: ${CONTAINER_ID}"
echo "URL: https://${CONTAINER_ID}.containers.${REGION}.scw.cloud"
