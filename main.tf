provider "google" {
  project = "verdant-tempest-378609"
  region  = "us-central1"
}

resource "google_compute_instance" "my-instance" {
  name         = "my-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  tags = ["test-server"]
}

# Create a firewall rule to allow HTTP traffic
resource "google_compute_firewall" "http" {
  name    = "http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["test-server"]
}

# Create a firewall rule to allow HTTPS traffic
resource "google_compute_firewall" "https" {
  name    = "https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["test-server"]
}

