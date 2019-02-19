resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app", "${var.env_tag}", "${var.issethttp}"]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    ssh-keys = "${var.ssh-user}:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    user        = "${var.ssh-user}"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  # provisioner "file" {
  #   source      = "../modules/app/files/deploy.sh"
  #   destination = "/tmp/deploy.sh"
  # }

  # provisioner "remote-exec" {
  #   inline = ["chmod +x /tmp/deploy.sh", "sudo /tmp/deploy.sh ${var.db-address}"]
  # }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "default-allow-puma"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["${var.my_ip}"]
  target_tags   = ["reddit-app"]
}
