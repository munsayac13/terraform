variable "project" {
  default = "MyLocalProject"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "gke_version" {
  default = "1.31"
}


variable "specific_group" {
  type    = string
  default = "group:specificgroup@domain.com"
}

variable "group_bigtable_roles" {
  type    = list(string)
  default = [
    "roles/bigtable.admin",
    "roles/cloudfunctions.developer",
    "roles/cloudscheduler.admin",
    "roles/deploymentmanager.editor",
  ]
}

variable "group_bigtable_projects" {
  type   = list(string)
  default = [
    "MyLocalProject",
    "SecondLocalProject",
    "ThirdLocalProject"
  ]
}

locals {
   project_role_combination_list = distinct(flatten([
    for project in var.group_bigtable_projects : [
      for role in var.group_bigtable_roles : {
        project = project
        role    = role
      }
    ]
  ]))
}
