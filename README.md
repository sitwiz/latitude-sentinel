# 🛰️ Sentinel OS: Bare Metal Validator Orchestration
### *Exclusively Engineered for Latitude.sh High-Performance Silicon*

**Sentinel OS** is a specialized, non-containerized infrastructure layer designed to deploy and manage production-grade Ethereum nodes with zero virtualization overhead. By bypassing Docker, Sentinel OS grants validators direct, low-latency access to **Latitude.sh Bare Metal**, maximizing IOPS and ensuring high-fidelity attestation.

<<<<<<< HEAD
curl -sSL https://raw.githubusercontent.com/sitwiz/latitude-sentinel/main/install.sh | bash

*Developed for the Latitude.sh 2026 Developer Grant.*
=======
---

## 🏎️ Why Sentinel OS? "The Metal Edge"
Most "one-click" installers rely on Docker abstraction layers. Sentinel OS is a **Non-Containerized Binary Orchestrator**. We prioritize **Maximum Extractable Performance (MEP)** over convenience.

* **Zero Virtualization Tax**: Running **Reth** and **Lighthouse** directly on the host OS eliminates the 5–10% CPU/Network overhead inherent in containerized environments.
* **Direct NVMe Throughput**: High-intensity state-writing is executed at native disk speeds—critical for Ethereum’s growing state size and heavy I/O requirements.
* **Self-Healing Resilience**: Managed via **PM2** with sub-500ms process resurrection, ensuring 99.99% uptime and protecting validators from inactivity penalties.

---

## 🏗️ Project Architecture
Sentinel OS is built to leverage the **64GB+ RAM** and **Epyc/Xeon** specifications of Latitude.sh instances:

* **/terraform**: Automated provisioning for global multi-region deployment (AMS1, TYO1, NYC1).
* **server.js**: A lightweight Node.js sidecar API pulling real-time kernel-level telemetry.
* **mcp-server.js**: **Model Context Protocol (MCP)** integration, making the node's health "AI-Readable" for automated audits.
* **/scripts**: Python-based autonomous health management via **Latitude API v2**.
* **Engine API Handshake**: Automated JWT generation for secure EL (Reth) and CL (Lighthouse) synchronization.

---

## 🚀 Phase 2 Features (Active)
* **Infrastructure-as-Code (IaC)**: Deploy new validator nodes in seconds via Terraform blueprints.
* **AI-Ready Audits**: Official **MCP SDK** implementation for automated hardware health and sync reporting.
* **Checkpoint Sync**: Pre-configured consensus tracking for near-instant node readiness on the Beacon Chain.

---

## 🛠️ Latitude.sh Deployment
To initialize the Sentinel OS environment on a **Latitude.sh Ubuntu 24.04** instance, execute the universal binary orchestrator:

```bash
curl -sSL [https://raw.githubusercontent.com/sitwiz/latitude-sentinel/main/install.sh](https://raw.githubusercontent.com/sitwiz/latitude-sentinel/main/install.sh) | bash
>>>>>>> d84372b (Feat: Integrated official MCP SDK for AI-Ready hardware audits)
