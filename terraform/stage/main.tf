provider "google" {
  version = "1.19.1"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source           = "../modules/app"
  public_key_path  = "${var.public_key_path}"
  zone             = "${var.zone}"
  app_disk_image   = "${var.app_disk_image}"
  ssh-user         = "${var.ssh-user}"
  private_key_path = "${var.private_key_path}"
  db-address       = "${module.db.db_internal_ip}"
  my_ip            = "${var.my_ip}"
  env_tag          = "${var.env_tag}"
  issethttp        = "http-server" // open 80 port
}

module "db" {
  source           = "../modules/db"
  public_key_path  = "${var.public_key_path}"
  zone             = "${var.zone}"
  db_disk_image    = "${var.db_disk_image}"
  ssh-user         = "${var.ssh-user}"
  private_key_path = "${var.private_key_path}"
  env_tag          = "${var.env_tag}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}
