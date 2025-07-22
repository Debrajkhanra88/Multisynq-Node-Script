# 🛰️ Multi-Node Multisynq Synchronizer Setup (Docker)

This repository contains ready-to-use scripts to run and manage **5 Multisynq Synchronizer nodes** using Docker.

---

## 📦 Prerequisites

Make sure you have the following installed:

- [Docker](https://docs.docker.com/get-docker/)
- (Optional) `git` to clone this repository

---

## 🚀 Installation

## Clone the repository

```bash
git clone https://github.com/Debrajkhanra88/Multisynq-Node-Script.git
cd Multisynq-Node-Script

---

## Make sure scripts are executable

chmod +x run-multinodes.sh


# ⚙️ Configuration
You need 5 unique wallet addresses and 5 unique SYNQ keys.

nano run-multinodes.sh

# ▶️ Start Nodes
To start 5 synchronizer nodes, run the script:


./run-multinodes.sh

# ⏹ Stop Nodes
To stop all the running synchronizer containers:

docker ps -a | grep synchronizer-cli | awk '{print $1}' | xargs docker stop

# 🧼 Remove Stopped Containers
To clean up stopped containers:

docker ps -a | grep synchronizer-cli | awk '{print $1}' | xargs docker rm -f

# 🪵 View Logs
To view logs of a particular node:

docker logs synchronizer-cli-0  # Replace 0 with the node number (0–4)

