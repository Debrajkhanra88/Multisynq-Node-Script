cat << 'EOF' > stop_all_synchronizers.sh
#!/bin/bash

NODES=(node1 node2 node3 node4 node5)

for NODE in "${NODES[@]}"; do
  echo "🛑 Stopping and removing $NODE..."
  docker stop "$NODE" >/dev/null 2>&1 && docker rm "$NODE" >/dev/null 2>&1
done

echo "✅ All synchronizer nodes stopped and removed."
EOF

