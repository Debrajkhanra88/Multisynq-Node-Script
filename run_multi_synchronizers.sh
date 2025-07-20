cat << 'EOF' > run_multi_synchronizers.sh
#!/bin/bash

LAUNCHER="cli-x/docker-x"
IMAGE="cdrakep/synqchronizer:latest"
DEPIN_URL="wss://api.multisynq.io/depin"

NODES=(
  "node1 synq-node-1 0x1111111111111111111111111111111111111111 3333 9290 11111111-1111-1111-1111-111111111111"
  "node2 synq-node-2 0x2222222222222222222222222222222222222222 3334 9291 22222222-2222-2222-2222-222222222222"
  "node3 synq-node-3 0x3333333333333333333333333333333333333333 3335 9292 33333333-3333-3333-3333-333333333333"
  "node4 synq-node-4 0x4444444444444444444444444444444444444444 3336 9293 44444444-4444-4444-4444-444444444444"
  "node5 synq-node-5 0x5555555555555555555555555555555555555555 3337 9294 55555555-5555-5555-5555-555555555555"
)

for node in "${NODES[@]}"; do
  read -r NODE_ID SYNC_NAME WALLET API_PORT METRICS_PORT SYNQ_KEY <<< "$node"
  
  echo "🚀 Launching $NODE_ID with ports $API_PORT (API) and $METRICS_PORT (metrics)..."

  docker run -d --name "$NODE_ID" --pull always --platform linux/amd64 \
    -p ${API_PORT}:3333 -p ${METRICS_PORT}:9090 \
    $IMAGE \
    --depin "$DEPIN_URL" \
    --sync-name "$SYNC_NAME" \
    --launcher "$LAUNCHER" \
    --key "$SYNQ_KEY" \
    --wallet "$WALLET"
done
EOF

