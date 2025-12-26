#!/bin/bash

# Update script for Docker containers
# This script helps update all running containers

set -e

echo "================================================"
echo "Tower Server Update Script"
echo "================================================"
echo ""

# Pull latest images
echo "Pulling latest images..."
docker compose pull

echo ""
echo "================================================"
echo "Update Complete!"
echo "================================================"
echo ""
echo "To apply updates, restart your containers:"
echo "  docker compose down"
echo "  docker compose up -d"
echo ""
echo "Or recreate containers without downtime:"
echo "  docker compose up -d --force-recreate"
echo ""
