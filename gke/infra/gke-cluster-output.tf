output "cluster-name" {
  value = google_container_cluster.gke-cluster.name
}

output "cluster-location" {
  value = google_container_cluster.gke-cluster.location
}