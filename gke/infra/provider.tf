# setup the GCP and kubernetes provider

provider "google" {
  project = var.project_id
  region  = var.gcp_region_1
  zone    = var.gcp_zone_1
  credentials = "/Users/jai/mydata/technical/credentials/codegarage-001-408013-compute-default.json"
}

provider "helm" {
  kubernetes {

    host                   = "https://${google_container_cluster.gke-cluster.endpoint}"
    cluster_ca_certificate = base64decode(google_container_cluster.gke-cluster.master_auth.0.cluster_ca_certificate)
    token                  = data.google_client_config.default.access_token
    client_certificate     = base64decode(google_container_cluster.gke-cluster.master_auth.0.client_certificate)
    client_key             = base64decode(google_container_cluster.gke-cluster.master_auth.0.client_key)
  }
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.gke-cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  client_certificate     = base64decode(google_container_cluster.gke-cluster.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster.gke-cluster.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.gke-cluster.master_auth.0.cluster_ca_certificate)
}
