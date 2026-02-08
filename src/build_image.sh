#!/bin/bash

set -euo pipefail

: "${UBUNTU_VERSION:?UBUNTU_VERSION is required}"
: "${PYTHON_VERSION:?PYTHON_VERSION is required}"
: "${DOCKERHUB_USERNAME:?DOCKERHUB_USERNAME is required}"

QUICK_BUILD="${QUICK_BUILD:-false}"
OPENSSL_VERSION="${OPENSSL_VERSION:-3.6.1}"
CREATION_COMMIT_SHA="${GITHUB_SHA:-local}"

UBUNTU_ADJECTIVE=$(bash src/ubuntu_adjective.sh --ubuntu=${UBUNTU_VERSION})
ARCH_SUFFIX=""
if [ -n "${ARCH}" ]; then
  ARCH_SUFFIX="-${ARCH}"
fi
IMAGE_TAG="${PYTHON_VERSION}${ARCH_SUFFIX}"


# Build the corresponding image
docker build . \
  --file ./src/Dockerfile \
  --tag "${DOCKERHUB_USERNAME}/${UBUNTU_ADJECTIVE}-python:${IMAGE_TAG}" \
  --build-arg "PY_VERSION=${PYTHON_VERSION}" \
  --build-arg "UBUNTU_VERSION=${UBUNTU_VERSION}" \
  --build-arg "CREATION_COMMIT_SHA=${CREATION_COMMIT_SHA}" \
  --build-arg QUICK_BUILD="${QUICK_BUILD}" \
  --build-arg OPENSSL_VERSION="${OPENSSL_VERSION}"
