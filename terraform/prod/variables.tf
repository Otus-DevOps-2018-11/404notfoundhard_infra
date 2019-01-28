variable project {
  description = "project id"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable ssh-user {
  description = "user for connection"
  default     = "gcp_appUser"
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

variable disk_image {
  description = "Disk image"
}

variable "count" {
  description = "counter"
  default     = 1
}

variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-ruby-base"
}

variable "db_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-db-base"
}
