resource "google_container_cluster" "gke-cluster" {
  name               = var.cluster_name
  location           = var.gcp_zone_1
  initial_node_count = 2
  deletion_protection = false

  node_config {
    machine_type = "e2-small"
    spot = true
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}