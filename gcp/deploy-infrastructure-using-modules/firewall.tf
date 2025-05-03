resource "google_compute_firewall" "default_base" {
  name = "default_base"
  network = module.vpc.network_name
  #source_ranges = [ module.vpc.subnets[*].subnet_ip ]
  source_ranges = [ 0.0.0.0/0 ]
  allow {
    protocol = "tcp"
    ports    = "80"
  } 

  allow {
    protocol = "tcp"
    ports    = "443"
  } 

}
