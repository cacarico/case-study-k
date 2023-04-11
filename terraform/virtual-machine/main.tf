resource "google_compute_address" "default" {
  name = "public-ip"
}

resource "google_compute_instance" "default" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
    }
  }

  network_interface {
    network = var.network

    access_config {
      nat_ip = google_compute_address.default.address
    }
  }

  // Apply the firewall rule to allow external IPs to access this instance
  tags = ["apache", "ssh"]
}

resource "google_compute_firewall" "apache" {
  name    = format("%s-firewall", var.name)
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["apache"]
}

resource "google_compute_firewall" "ssh" {
  name    = format("%s-ssh", var.name)
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = [var.ssh_ip]
  target_tags   = ["ssh"]
}

