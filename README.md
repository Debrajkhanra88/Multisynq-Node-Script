# 🚀 Multisynq Multi-Node Synchronizer Setup

This repository provides scripts to deploy **5 Multisynq synchronizer nodes** with:
- ✅ Predefined **valid sync-names**
- ✅ Unique **SYNQ_KEYS** for each node
- ✅ Unique **Wallet addresses**
- ✅ Separate **ports** and **containers** per node
- ✅ Retry logic if a node fails to start

---

## 📦 Installation Process

1. **Clone this repository**:
   ```bash
   git clone https://github.com/Debrajkhanra88/Multisynq-Node-Script.git
   cd Multisynq-Node-Script
   ```

2. **Make scripts executable**:
   ```bash
   chmod +x run_multi_synchronizers.sh stop_nodes.sh logs_nodes.sh
   ```

3. **Update your configuration**:

  Open run_multi_synchronizers.sh

  Edit the following arrays with your valid values:

  SYNC_NAMES → Registered sync-names

  SYNQ_KEYS → Your issued SYNQ keys

  WALLETS → Ethereum wallet addresses linked to each node
  ```bash
  nano run_multi_synchronizers.sh
  ```

4. **▶️ Start All Nodes**:
   ``bash
  ./run_multi_synchronizers.sh
  ```

5. **🛑 Stop All Nodes**:
   ```bash
  ./stop_nodes.sh
  ```

6. **📜 View Logs for Each Node**:
   ```bash
  ./logs_nodes.sh 1   # Logs for node 1
  ./logs_nodes.sh 3   # Logs for node 3
  ```
  Example:
  ```bash
  docker logs -f synchronizer-cli-1
  ```

