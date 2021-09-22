#!/bin/bash

UBUNTU_ADJECTIVE=$(bash src/ubuntu_adjective.sh --ubuntu=${UBUNTU_VERSION})
docker create -t -i --name test-container ${DOCKERHUB_USERNAME}/${UBUNTU_ADJECTIVE}-python:${PYTHON_VERSION}
docker start test-container
docker exec -i test-container python3 < src/test_image.py
