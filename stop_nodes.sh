#!/bin/bash
# ================================================
# Stop and Remove All MultiSynq Node Containers
# ================================================

for i in {1..5}; do
  CONTAINER="synchronizer-cli-$i"
  echo "🛑 Stopping and removing $CONTAINER..."
  docker stop $CONTAINER 2>/dev/null
  docker rm $CONTAINER 2>/dev/null
done

echo "✅ All MultiSynq node containers stopped and removed!"

