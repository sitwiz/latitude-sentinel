import os
import requests
import time

# --- CONFIGURATION (Now via Environment Variables) ---
API_KEY = os.getenv("LATITUDE_API_KEY")
PROJECT_ID = "proj_gXQvNeZeE5zpb"  # Hardcoded for your project, or use os.getenv("PROJECT_ID")
CHECK_INTERVAL = 60  # seconds

def check_health():
    if not API_KEY:
        print("❌ Error: LATITUDE_API_KEY environment variable not set.")
        return

    print(f"🔍 Checking Sentinel node health at {time.strftime('%H:%M:%S')}...")
    
    # Example logic: Check if the Latitude API can reach your project
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    url = f"https://api.latitude.sh/projects/{PROJECT_ID}/servers"
    
    try:
        response = requests.get(url, headers=headers)
        if response.status_code == 200:
            print("✅ Systems Nominal. Sentinel OS is online.")
        else:
            print(f"⚠️ Warning: API returned status {response.status_code}. Possible downtime.")
            # Trigger "Self-Healing" reboot logic here if needed
    except Exception as e:
        print(f"🚨 Connection Error: {e}")

if __name__ == "__main__":
    print("🤖 Sentinel-Bot v2.0 (Zero-Config Mode) Started.")
    while True:
        check_health()
        time.sleep(CHECK_INTERVAL)
