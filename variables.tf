variable "location" {
  description = "Azure region for the lab"
  type        = string
  default     = "swedencentral"
}

variable "vm_size" {
  description = "Size of the lab virtual machines"
  type        = string
  default     = "Standard_B2pts_v2"
}

variable "admin_username" {
  description = "Local administrator username for the Linux VMs"
  type        = string
  default     = "azureadmin"
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}

## Uncomment below when experimenting DNAT ##

# variable "admin_source_ip" {
#   description = "Public IPv4 address (without /32). Set in terraform.tfvars, never commit."
#   type        = string
#   sensitive   = true
# }