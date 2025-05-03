terraform {
  required_providers {
    google = {
      source = "hashicorp/google"

    }
  }
  backend "gcs" {
    bucket  = "mylocalonebucket"
    prefix  = "terraform/state"
  }

}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

