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

