resource "google_service_account" "kubernetes_service_account" {
  account_id      = "kubernetes-sa"
  display_name    = "kubernetes-sa"
  description     = "This is for kubernetes"
}

resource "google_service_account_key" "kubernetes_service_account_key" {
  service_account_id = google_service_account.kubernetes_service_account.name
}

output "kubernetes_service_account_key" {
  value = base64decode(google_service_account_key.kubernetes_service_account_key.private_key)
}

resource "google_service_account" "workload_identity_service_account" {
  account_id      = "workload-identity-sa"
  display_name    = "workload-identity-sa"
}

resource "google_project_iam_member" "storage_role" {
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.workload_identity_service_account.email}"
}

#resource "google_project_iam_member" "workload_identity_role" {
#  role = "roles/iam.workloadIdentityUser"
#  member = serviceAccount:${var.project}.svc.id.goog[workload-identity-test/workload-identity-user]"
#}


### ASSIGN MULTIPLE GOOGLE CLOUD IAM ROLES TO SERVICE ACCOUNT 

resource "google_project_iam_member" "multi_member_role" {
  for_each = toset([
    "roles/cloudsql.admin",
    "roles/secretmanager.secretAccessor",
    "roles/datastore.owner",
    "roles/storage.admin",
    "roles/cloudfunctions.admin",
    "roles/bigtable.developer",
    "roles/cloudscheduler.admin",
    "roles/deploymentmanager.editor",
  ])
  role = each.key
  member = "serviceAccount:${google_service_account.kubernetes_service_account.email}"
  project = var.project
}

#OR
#data "google_iam_policy" "kubernetes_service_account_iam_policy" {
#  binding {
#    role = "roles/cloudsql.admin"
#    members = [
#      "serviceAccount:${google_service_account.kubernetes_service_account.email}",
#    ]
#  }
#  binding {
#    role = "roles/secretmanager.secretAccessor"
#    members = [
#      "serviceAccount:${google_service_account.kubernetes_service_account.email}",
#    ]
#  }
#  binding {
#    role = "roles/datastore.owner"
#    members = [
#      "serviceAccount:${google_service_account.kubernetes_service_account.email}",
#    ]
#  }
#  binding {
#    role = "roles/storage.admin"
#    members = [
#      "serviceAccount:${google_service_account.kubernetes_service_account.email}",
#    ]
#  }
#}

resource "google_project_iam_member" "specific_group_bigtable_roles" {
  for_each = { for entry in local.project_role_combination_list: "${entry.project}.${entry.role}" => entry }
  project  = each.value.project
  role     = each.value.role
  member   = var.specific_group
}

