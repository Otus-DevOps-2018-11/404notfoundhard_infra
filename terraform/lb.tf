#группируем инстансы
resource "google_compute_instance_group" "puma-group" {
  name        = "puma-group"
  zone        = "${var.zone}"
  description = "Instance group for puma"

  instances = [
    "${google_compute_instance.app.*.self_link}",
  ]

  named_port {
    name = "http"
    port = "9292"
  }
}

# создаем health checker
resource "google_compute_health_check" "health-checker" {
  name               = "health-checker"
  timeout_sec        = 2
  check_interval_sec = 3

  tcp_health_check {
    port = "9292"
  }
}

resource "google_compute_backend_service" "puma-backend" {
  name        = "puma-backend"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 5

  backend {
    group = "${google_compute_instance_group.puma-group.self_link}"
  }

  health_checks = [
    "${google_compute_health_check.health-checker.self_link}",
  ]
}

resource "google_compute_url_map" "puma-url-map" {
  name            = "puma-url-map"
  default_service = "${google_compute_backend_service.puma-backend.self_link}"
}

resource "google_compute_target_http_proxy" "puma-proxy" {
  name    = "puma-proxy"
  url_map = "${google_compute_url_map.puma-url-map.self_link}"
}

resource "google_compute_global_forwarding_rule" "puma-forward" {
  name       = "puma-forward"
  target     = "${google_compute_target_http_proxy.puma-proxy.self_link}"
  port_range = "80"
}
