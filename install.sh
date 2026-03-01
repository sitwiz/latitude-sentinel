#!/bin/bash
# Sentinel OS - High Performance Bare Metal Orchestrator
# Optimized for Ubuntu 24.04 x86_64

set -e # Exit immediately if a command fails

echo "🚀 Initializing Sentinel OS on Bare Metal..."

# 1. Update System & Install Dependencies
sudo apt-get update
sudo apt-get install -y curl git jq nodejs npm

# 2. Install PM2 Globally
sudo npm install -g pm2

# 3. Create Sentinel Directory & Setup API
cd $HOME/latitude-sentinel
npm install

# 4. Fetch Official Binaries (Reth & Lighthouse)
echo "📦 Fetching Protocol Binaries..."
# Reth v1.1.0
curl -L https://github.com/paradigmxyz/reth/releases/download/v1.1.0/reth-v1.1.0-x86_64-unknown-linux-gnu.tar.gz | tar -xz
# Lighthouse v5.3.0
curl -L https://github.com/sigp/lighthouse/releases/download/v5.3.0/lighthouse-v5.3.0-x86_64-unknown-linux-gnu.tar.gz | tar -xz

# 5. Engine API Handshake (JWT)
if [ ! -f jwt.hex ]; then
  openssl rand -hex 32 > jwt.hex
  echo "🔑 New JWT Secret generated."
fi

# 6. Launch the Sentinel Stack
echo "🛰️ Launching Sentinel Orchestrator..."

# Start the Dashboard API
pm2 start server.js --name "sentinel-api"

# Start the AI-Ready MCP Bridge
pm2 start mcp-server.js --name "sentinel-mcp"

# Start Ethereum Layers (Hiberated by default for resource saving)
# To enable: pm2 start ./reth --name eth-execution ...
# To enable: pm2 start ./lighthouse --name eth-consensus ...

echo "✅ Deployment Complete!"
echo "📊 Dashboard: http://$(curl -s ifconfig.me):5173"
echo "🤖 MCP Bridge is ONLINE for AI-Audits."
