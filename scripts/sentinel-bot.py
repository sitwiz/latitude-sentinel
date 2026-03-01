import requests
import time
import os

# Latitude API Config
API_KEY = os.getenv("LATITUDE_API_KEY")
SERVER_ID = "sv_your_server_id" # We'll get this from your dashboard
HEADERS = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}

def check_node_health():
    # Check if your local Solana/Reth node is responding
    try:
        response = requests.post("http://localhost:8545", json={"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}, timeout=5)
        return response.status_code == 200
    except:
        return False

def trigger_self_healing():
    print("⚠️ Node Unhealthy! Triggering Latitude.sh Reboot...")
    url = f"https://api.latitude.sh/project/servers/{SERVER_ID}/actions"
    payload = {"type": "reboot"}
    requests.post(url, json=payload, headers=HEADERS)

while True:
    if not check_node_health():
        trigger_self_healing()
    time.sleep(300) # Check every 5 minutes
