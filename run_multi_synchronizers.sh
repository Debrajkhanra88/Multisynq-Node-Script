#!/bin/bash
# =======================================================
# Multi-Node Synchronizer Launcher (Self-Healing Version)
# =======================================================

IMAGE="cdrakep/synqchronizer:latest"
LAUNCHER="cli-2.6.1/docker-2025-06-24"
API_BASE=3333
METRICS_BASE=9290
MAX_RETRIES=3

# ✅ Predefined sync names
SYNC_NAMES=("synq-31c43a1df276" "synq-31c43a1df277" "synq-31c43a1df278" "synq-31c43a1df279" "synq-31c43a1df280")

# ✅ Predefined keys
SYNQ_KEYS=("dc1c60f6-0d87-4a3b-9ce4-73f71fd624fa" \
           "bf831a9c-f9ef-49f2-998a-7c4ff923a25d" \
           "e733c4ac-4e2b-4140-ae14-b351d0bbb8f7" \
           "d0a566d6-868b-4777-b021-5e4be4df25ac" \
           "8d0804dc-291f-475c-8a6e-e2384c059fae")

# ✅ Wallets
WALLETS=(
"0x763d3907074AeB9b57776E157754AEE6E4dAaAaf"
"0x9eC218041f4fA2d80fe05BC174bC5823Ffac5663"
"0x7d9c02FFA95A5eF87F08F3975A149e901a8C9D76"
"0xCbf432c100C6F5D7868E22Edc8a45c18B240C33E"
"0xb1C8B799365c0fCdF9661c8ffc3e12e4A61e92a4"
)

# ✅ Random generator
generate_random() { tr -dc 'a-z0-9' </dev/urandom | head -c 6; }

# =======================================================
# 🚀 Start Nodes
# =======================================================
for i in {1..5}; do
  API_PORT=$((API_BASE + i - 1))
  METRICS_PORT=$((METRICS_BASE + i - 1))
  NAME="${SYNC_NAMES[$((i-1))]}"
  CONTAINER="synchronizer-cli-$i"
  KEY="${SYNQ_KEYS[$((i-1))]}"
  WALLET="${WALLETS[$((i-1))]}"

  # Cleanup if container exists
  docker rm -f "$CONTAINER" >/dev/null 2>&1

  echo "🚀 Starting $NAME on API:$API_PORT METRICS:$METRICS_PORT"

  attempt=1
  while [ $attempt -le $MAX_RETRIES ]; do
    docker run -d --restart unless-stopped \
      --name "$CONTAINER" \
      --platform linux/amd64 \
      -p "$API_PORT":3333 -p "$METRICS_PORT":9090 \
      "$IMAGE" \
      --depin wss://api.multisynq.io/depin \
      --sync-name "$NAME" \
      --launcher "$LAUNCHER" \
      --key "$KEY" \
      --wallet "$WALLET"

    sleep 10
    LOGS=$(docker logs "$CONTAINER" 2>&1 | tail -n 20)

    if echo "$LOGS" | grep -q "INVALID-NAME"; then
      NAME="synq-auto-$(generate_random)"
      echo "⚠️ INVALID NAME detected → retrying with $NAME"
      docker rm -f "$CONTAINER"
      attempt=$((attempt+1))
      continue
    fi

    if echo "$LOGS" | grep -q "INVALID-SYNQ-KEY"; then
      KEY="key-auto-$(generate_random)"
      echo "⚠️ INVALID KEY detected → retrying with $KEY"
      docker rm -f "$CONTAINER"
      attempt=$((attempt+1))
      continue
    fi

    echo "✅ $NAME started successfully (attempt $attempt)"
    break
  done

  if [ $attempt -gt $MAX_RETRIES ]; then
    echo "❌ $NAME failed after $MAX_RETRIES retries!"
  fi
done

echo "✅ All nodes processed."

