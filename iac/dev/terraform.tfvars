project_id = "codegarage-001-408013"

# Compute Instances
instances = [
  # Grafana App Server Configuration
  {
    instance_machine_type              = "e2-medium"
    instance_name                      = "grafana"
    instance_zone                      = "us-east1-b"
    instance_description               = "Grafana App Server"
    instance_tags                      = ["web-server"]
    instance_allow_stopping_for_update = true
    instance_network_interface = [
      {
        network            = "projects/codegarage-001-408013/global/networks/default"
        subnetwork         = "projects/codegarage-001-408013/regions/us-east1/subnetworks/default"
        subnetwork_project = "codegarage-001-408013"
      }
    ]
    instance_boot_disk = {
      auto_delete = true
      initialize_params = {
        size  = 10
        type  = "pd-standard"
        image = "projects/debian-cloud/global/images/debian-11-bullseye-v20231212"
      }
    }
    instance_labels = {
      "env" = "dev",
      "provisioned_by" = "terraform"
    }
    instance_metadata_startup_script = "startup_script_grafana.sh"

    instance_scheduling = {
      on_host_maintenance = "MIGRATE"
      node_affinities     = []
    }

    instance_service_account = {
      email = "918294306826-compute@developer.gserviceaccount.com"
      "scopes" : ["https://www.googleapis.com/auth/cloud-platform"]
    }
  }
]