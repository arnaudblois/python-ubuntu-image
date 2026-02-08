#!/bin/bash

set -euo pipefail

: "${UBUNTU_VERSION:?UBUNTU_VERSION is required}"
: "${PYTHON_VERSION:?PYTHON_VERSION is required}"
: "${DOCKERHUB_USERNAME:?DOCKERHUB_USERNAME is required}"

UBUNTU_ADJECTIVE=$(bash src/ubuntu_adjective.sh --ubuntu=${UBUNTU_VERSION})
ARCH_SUFFIX=""
if [ -n "${ARCH}" ]; then
  ARCH_SUFFIX="-${ARCH}"
fi
IMAGE_TAG="${PYTHON_VERSION}${ARCH_SUFFIX}"
CONTAINER_NAME="test-container-${RANDOM}-${RANDOM}"

cleanup() {
  docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true
}
trap cleanup EXIT

docker create -t -i --name "${CONTAINER_NAME}" "${DOCKERHUB_USERNAME}/${UBUNTU_ADJECTIVE}-python:${IMAGE_TAG}"
docker start "${CONTAINER_NAME}"
docker exec -i "${CONTAINER_NAME}" python3 < src/test_image.py
