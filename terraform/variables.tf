# 1. Security: Your Secret API Key
variable "latitudesh_auth_token" {
  type        = string
  description = "Latitude.sh Personal Access Token"
  sensitive   = true # Redacts the key from logs so it doesn't leak
}

# 2. Location: Where the server lives
variable "region" {
  type        = string
  description = "The Latitude.sh site slug (e.g., AMS1, TYO1, NYC1)"
  default     = "AMS1" # Default to your current Amsterdam home
}

# 3. Hardware: The "Workhorse" specs
variable "plan" {
  type        = string
  description = "The server plan slug"
  default     = "m4-metal-small"
}

# 4. Access: Your Public SSH Key
variable "public_ssh_key" {
  type        = string
  description = "Your public SSH key for secure root access"
}

# 5. Project Meta: Keep it organized
variable "environment" {
  type        = string
  description = "Environment name (Development/Production)"
  default     = "Production"
}
