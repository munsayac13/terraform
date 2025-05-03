resource "google_compute_instance" "mylocalone_instance_1" {
  name         = "mylocalone-instance-1"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      Size = "20"
    }
  }

  network_interface {
    network = module.vpc.network_name 
    subnetwork = modules.vpc.subnets[0].subnet_name
  }
}


resource "google_compute_instance" "mylocalone_instance_2" {
  name         = "mylocalone-instance-2"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      Size = "20"
    }
  }

  network_interface {
    network = module.vpc.network_name
    subnetwork = module.vpc.subnets[1].subnet_name
  }
}
