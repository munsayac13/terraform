provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = file("service-account-credential.json")
}

#OR
#provider "google" {
#  project = "<YOUR_GCP_PROJECT_ID>"
#  region = "<YOUR_GCP_REGION>"
#}
