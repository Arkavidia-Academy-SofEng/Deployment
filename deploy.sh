#!/bin/bash
set -e

echo "Creating Docker Swarm networks..."
cd networks
docker network create --driver overlay internal-app || true
docker network create --driver overlay internal-db || true
cd ..

echo "Deploying database stack..."
cd database
docker stack deploy -c docker-compose.yml db_stack
cd ..

echo "Deploying Redis stack..."
cd redis
docker stack deploy -c docker-compose.yml redis_stack
cd ..

echo "Deploying backend stack..."
cd backend
docker stack deploy -c docker-compose.yml backend_stack
cd ..

echo "Deploying frontend stack..."
cd frontend
docker stack deploy -c docker-compose.yml frontend_stack
cd ..

echo "All stacks deployed successfully!"
echo "Check status with: docker stack ls"