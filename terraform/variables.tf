variable "aws_region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "ap-southeast-1"
}

variable "instance_type" {
  description = "EC2 size. Odoo + PostgreSQL need at least 2 GB RAM (t3.small). Not free-tier: destroy after practice."
  type        = string
  default     = "t3.small"
}

variable "admin_cidr" {
  description = "Your public IP in CIDR form (for example 203.0.113.10/32). SSH is only allowed from here."
  type        = string

  validation {
    condition     = can(cidrhost(var.admin_cidr, 0)) && var.admin_cidr != "0.0.0.0/0"
    error_message = "admin_cidr must be a valid CIDR and must not be 0.0.0.0/0."
  }
}

variable "ssh_public_key" {
  description = "Contents of your SSH public key (ssh-ed25519 ...)."
  type        = string
}
