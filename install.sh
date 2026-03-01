#!/bin/bash
echo "🚀 Sentinel OS: Provisioning Full Ethereum Beacon Node (Reth + Lighthouse)..."

# 1. System Prep
sudo apt-get update && sudo apt-get install -y git curl openssl
sudo npm install -g pm2

# 2. Generate the JWT Secret (The Digital Handshake)
# Without this, Reth and Lighthouse won't talk to each other.
mkdir -p ~/latitude-sentinel/secrets
openssl rand -hex 32 | tee ~/latitude-sentinel/secrets/jwt.hex > /dev/null
chmod 644 ~/latitude-sentinel/secrets/jwt.hex

# 3. Install Reth (Execution Layer)
echo "📦 Downloading Reth v1.1.0..."
curl -L https://github.com/paradigmxyz/reth/releases/download/v1.1.0/reth-v1.1.0-x86_64-unknown-linux-gnu.tar.gz | tar -xz
sudo mv reth /usr/local/bin/

# 4. Install Lighthouse (Consensus Layer)
echo "📦 Downloading Lighthouse..."
curl -L https://github.com/sigp/lighthouse/releases/download/v5.3.0/lighthouse-v5.3.0-x86_64-unknown-linux-gnu.tar.gz | tar -xz
sudo mv lighthouse /usr/local/bin/

# 5. Launch the Full Stack via PM2
echo "🔥 Starting Node Services..."

# Start Reth (The Engine)
pm2 start "reth node --authrpc.jwtsecret ~/latitude-sentinel/secrets/jwt.hex --http --http.api all" --name "eth-execution"

# Start Lighthouse (The Pilot) using Checkpoint Sync for instant start
pm2 start "lighthouse bn --network mainnet --execution-endpoint http://localhost:8551 --execution-jwt ~/latitude-sentinel/secrets/jwt.hex --checkpoint-sync-url https://mainnet.checkpoint-sync.ethpandaops.io --http" --name "eth-consensus"

# Start the Sentinel Dashboard
pm2 start ~/latitude-sentinel/server.js --name "sentinel-api"

pm2 save
echo "✅ SUCCESS: Full Beacon Node + Sentinel OS is LIVE."
echo "🔗 Monitor here: http://$(curl -s ifconfig.me):5173"
