variable ssh-user {
  description = "user for connection"
}

variable zone {
  description = "Zone, if var is null = us-east4-b"
  default     = "us-east4-c"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable "private_key_path" {
  description = "Path to the private key used for provision"
}

variable "db_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-db-base"
}

variable "env_tag" {
  description = "service tag application"
}

