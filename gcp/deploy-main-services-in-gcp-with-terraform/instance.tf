resource "google_compute_instance" "vm_instance_one" {
  name         = "vm-instance-one"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    ssh-keys = "username:ssh-rsa AAAAB3... rest of your SSH key"
  }
}
