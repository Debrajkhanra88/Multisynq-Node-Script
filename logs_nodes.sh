#!/bin/bash
# ================================================
# View Logs for All MultiSynq Node Containers
# ================================================

for i in {1..5}; do
  CONTAINER="synchronizer-cli-$i"
  echo "==============================================="
  echo "📜 Logs for $CONTAINER"
  echo "==============================================="
  docker logs --tail 50 -f $CONTAINER
done

