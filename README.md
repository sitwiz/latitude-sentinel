# 🛰️ Sentinel OS (Latitude.sh Edition)

A high-performance validator monitoring suite and self-healing infrastructure layer, purpose-built for **Latitude.sh Bare Metal**.

## 🏗️ Project Architecture
* **/src & server.js**: React + Node.js dashboard providing real-time Reth/Solana telemetry.
* **/terraform**: Automated provisioning for global multi-region validator deployment.
* **/scripts**: Python-based "Self-Healing" bot that monitors node health and interacts with Latitude API v2.

## 🚀 Phase 2 Features (Active)
- **Infrastructure-as-Code**: Deploy new validator nodes in any Latitude site (AMS1, TYO1, NYC1) via Terraform.
- **AI-Ready Monitoring**: Integrated with **Latitude.sh MCP Server** for automated hardware audits.
- **Self-Healing**: Automated reboot/re-provisioning logic triggered by on-chain sync lag.

## 🛠️ Usage
1. `npm install` && `npm run dev` to start the dashboard.
2. `cd terraform && terraform init` to scale the infrastructure.
3. `python3 scripts/sentinel-bot.py` to enable autonomous health management.

---
*Developed for the Latitude.sh 2026 Developer Grant.*
