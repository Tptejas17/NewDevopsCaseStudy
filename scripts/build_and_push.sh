#!/bin/bash
set -e

IMAGE_NAME="tejasparab17/casestudy-node-app:latest"

echo "[INFO] Building Docker image: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

echo "[INFO] Logging into DockerHub..."
echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

echo "[INFO] Pushing image to DockerHub..."
docker push $IMAGE_NAME

