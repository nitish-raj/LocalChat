#!/bin/bash

echo "Pulling latest images..."
docker compose pull

echo "Removing old containers..."
docker compose down

echo "Starting up with new images..."
docker compose up -d

echo "Cleaning up old images..."
docker image prune -f