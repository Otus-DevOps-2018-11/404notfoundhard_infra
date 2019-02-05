resource "google_compute_instance" "db" {
  name         = "reddit-db"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-db"]

  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  metadata {
    ssh-keys = "${var.ssh-user}:${file(var.public_key_path)}"
  }

  # connection {
  #   type        = "ssh"
  #   user        = "${var.ssh-user}"
  #   agent       = false
  #   private_key = "${file(var.private_key_path)}"
  # }

  # provisioner "remote-exec" {
  #   inline = ["sudo service mongod stop",
  #     "sudo sed -i 's/bindIp: 127.0.0.1/bindIp: ${self.network_interface.0.address}/' /etc/mongod.conf",
  #     "sudo service mongod start",
  #   ]
  # }
}

resource "google_compute_firewall" "firewall_mongo" {
  name    = "default-allow-mongodb"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  target_tags = ["reddit-db"]
  source_tags = ["reddit-app"]
}
