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

build_args=()
if [[ -n "${OPENSSL_VERSION:-}" ]]; then
  build_args+=(--build-arg "OPENSSL_VERSION=${OPENSSL_VERSION}")
fi

# Build the corresponding image
docker build . \
  --file ./src/Dockerfile \
  --tag "${DOCKERHUB_USERNAME}/${UBUNTU_ADJECTIVE}-python:${IMAGE_TAG}" \
  --build-arg PY_VERSION="${PYTHON_VERSION}" \
  --build-arg UBUNTU_VERSION="${UBUNTU_VERSION}" \
  --build-arg CREATION_COMMIT_SHA="${GITHUB_SHA:-$(git rev-parse HEAD)}" \
  --build-arg QUICK_BUILD="${QUICK_BUILD:-false}" \
  "${build_args[@]}"
