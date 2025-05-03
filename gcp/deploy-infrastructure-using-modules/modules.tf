module "instances" {
  source = "./modules/instances"
}

module "compute_storage" {
  source = "./modules/storage"
}

module "vpc" {
  source = "terraform-google-modules/network/google"
  version = "11.0.0"
  project_id = var.project_id
  network_name = var.vpc_name
  routing_mode = "GLOBAL"
  subnets = [
    {
      subnet_name = "mylocalone-private-subnet-1"
      subnet_ip   = "10.0.0.0/16"
      subnet_region = var.region
    },
    {
      subnet_name = "mylocalone-public-subnet-1"
      subnet_ip   = "10.11.0.0/16"
      subnet_region = var.region
    }
  ]
}
