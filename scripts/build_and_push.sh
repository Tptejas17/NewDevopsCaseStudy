#!/usr/bin/env bash
set -euo pipefail

IMAGE="tejasparab17/casestudy-node-app:latest"

echo "[INFO] Building Docker image: $IMAGE"
docker build -t $IMAGE .

echo "[INFO] Pushing image to DockerHub..."
docker push $IMAGE
