#!/bin/bash


UBUNTU_ADJECTIVE=$(bash src/ubuntu_adjective.sh --ubuntu=${UBUNTU_VERSION})


# Build the corresponding image
docker build . \
  --file ./src/Dockerfile \
  --tag ${DOCKERHUB_USERNAME}/${UBUNTU_ADJECTIVE}-python:${PYTHON_VERSION} \
  --build-arg PY_VERSION=${PYTHON_VERSION} \
  --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} \
  --build-arg CREATION_COMMIT_SHA="${GITHUB_SHA}" \
  --build-arg QUICK_BUILD="${QUICK_BUILD}" \
  --build-arg OPENSSL_VERSION="${OPENSSL_VERSION}"
