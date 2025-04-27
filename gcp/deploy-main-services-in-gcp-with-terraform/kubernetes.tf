resource "google_container_cluster" "gke_cluster_one" {
  name               = "gke-cluster-one"
  location           = var.region
  min_master_version = var.gke_version
  project            = var.project
  initial_node_count = 3
 
  # We can't create a cluster with no node pool defined, but
  # we want to only use separately managed node pools. So we
  # create the smallest possible default node pool and
  # immediately delete it.
  #remove_default_node_pool = true
  #initial_node_count = 1
  

  node_config {
    machine_type = "e2-medium"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  lifecycle {
    ignore_changes = [node_config]
    ignore_changes = [
      # Ignore changes to min-master-version as that gets changed
      # after deployment to minimum precise version Google has
      min_master_version,
    ]
  }

  #https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity
  #workload_identity_config {
  #  identity_namespace = "${var.project}.svc.id.goog"
  #}
}

resource "google_container_node_pool" "gke_cluster_one_primary_nodes" {
  cluster    = google_container_cluster.gke_cluster_one.name
  location   = google_container_cluster.gke_cluster_one.location
  project    = google_container_cluster.gke_cluster_one.project
  node_count = 3
  autoscaling {
    min_node_count = 3
    max_node_count = 4
  }

  node_config {
    preemptible  = false
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and
    # permissions granted via IAM Roles.
    service_account = google_service_account.kubernetes_service_account.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
  lifecycle {
    ignore_changes = [
      # Ignore changes to node_count, initial_node_count and version
      # otherwise node pool will be recreated if there is drift between what 
      # terraform expects and what it sees
      initial_node_count,
      node_count,
      version
    ]
  }
}
