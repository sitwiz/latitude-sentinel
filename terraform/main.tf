terraform {
  required_providers {
    latitudesh = {
      source  = "latitudesh/latitudesh"
      version = ">= 2.5.0"
    }
  }
}

provider "latitudesh" {
  auth_token = var.latitudesh_auth_token
}

# 1. THE SSH KEY (Global)
resource "latitudesh_ssh_key" "admin_key" {
  name       = "sentinel-admin-key"
  public_key = var.public_ssh_key
}

# 2. THE USER DATA (Global)
resource "latitudesh_user_data" "sentinel_init" {
  description = "Sentinel OS Bootstrap Script"
  content     = <<-EOF
#!/bin/bash
apt-get update
apt-get install -y nodejs npm git python3-pip
git clone https://github.com/sitwiz/latitude-sentinel.git /opt/sentinel
cd /opt/sentinel && npm install
npm install -g pm2
pm2 start server.js --name "sentinel-api"
pm2 save
pm2 startup
EOF
}

# 3. THE SERVER (Hard-wired to your specific Project)
resource "latitudesh_server" "validator_node" {
  hostname         = "sentinel-ams1-validator"
  site             = var.region
  plan             = var.plan
  operating_system = "ubuntu_22_04_x64_lts"
  billing          = "monthly"

  # Tying it directly to your project ID
  project          = "proj_gXQvNeZeE5zpb"

  ssh_keys         = [latitudesh_ssh_key.admin_key.id]
  user_data        = latitudesh_user_data.sentinel_init.id
}
