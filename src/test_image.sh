#!/bin/bash
set -euo pipefail

: "${UBUNTU_VERSION:?UBUNTU_VERSION is required}"
: "${PYTHON_VERSION:?PYTHON_VERSION is required}"
: "${DOCKERHUB_USERNAME:?DOCKERHUB_USERNAME is required}"

UBUNTU_ADJECTIVE=$(bash src/ubuntu_adjective.sh --ubuntu="${UBUNTU_VERSION}")
ARCH_SUFFIX=""
if [[ -n "${ARCH:-}" ]]; then
  ARCH_SUFFIX="-${ARCH}"
fi
IMAGE_TAG="${PYTHON_VERSION}${ARCH_SUFFIX}"

docker run --rm -i \
  --env PYTHON_VERSION \
  --env UBUNTU_VERSION \
  --env OPENSSL_VERSION \
  "${DOCKERHUB_USERNAME}/${UBUNTU_ADJECTIVE}-python:${IMAGE_TAG}" \
  python3 < src/test_image.py
