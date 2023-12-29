variable "project_id" {
  type        = string
  description = "Project ID in which resources are deployed"
}

variable "instances" {
  type = list(object({
    instance_machine_type = string,
    instance_name         = string,
    instance_zone         = string,
    instance_description  = optional(string, "Instance in Dev"),
    instance_network_interface = list(object({
      network            = optional(string)
      subnetwork         = optional(string)
      subnetwork_project = optional(string)
      network_ip         = optional(string)
      nic_type           = optional(string)
      stack_type         = optional(string)
      queue_count        = optional(number)
      access_config = optional(list(object({
        nat_ip                 = optional(string)
        public_ptr_domain_name = optional(string)
        network_tier           = optional(string)
      })))
      alias_ip_range = optional(object({
        ip_cidr_range         = optional(string)
        subnetwork_range_name = optional(string)
      }))
      ipv6_access_config = optional(object({
        public_ptr_domain_name = optional(string)
        network_tier           = optional(string)
      }))
    })),
    instance_boot_disk = object({
      auto_delete       = optional(bool)
      device_name       = optional(string)
      mode              = optional(string)
      kms_key_self_link = optional(string)
      source            = optional(string)
      initialize_params = optional(object({
        size  = optional(number)
        type  = optional(string)
        image = optional(string)
      }))
    }),
    instance_allow_stopping_for_update = optional(bool, null)
    instance_can_ip_forward            = optional(bool, null)
    instance_desired_status            = optional(string, "RUNNING")
    instance_deletion_protection       = optional(bool, false)
    instance_hostname                  = optional(string, null)
    instance_labels                    = optional(map(string), {})
    instance_metadata                  = optional(map(string), {})
    instance_metadata_startup_script   = optional(string, null)
    instance_min_cpu_platform          = optional(string, null)
    instance_tags                      = optional(list(string), [])
    instance_enable_display            = optional(bool, false)
    instance_resource_policies         = optional(list(string), null)
    instance_attached_disk = optional(list(object({
      source                  = optional(string)
      device_name             = optional(string)
      mode                    = optional(string)
      disk_encryption_key_raw = optional(string)
      kms_key_self_link       = optional(string)
    })), []),
    instance_guest_accelerator = optional(list(object({
      type  = optional(string)
      count = optional(number)
    })), [])
    instance_scheduling = optional(object({
      preemptible         = optional(bool)
      on_host_maintenance = optional(string)
      automatic_restart   = optional(bool)
      min_node_cpus       = optional(number)
      node_affinities = optional(list(object({

        key      = optional(string)
        operator = optional(string)
        values   = optional(string)
      })))
    }), {})
    instance_scratch_disk_interface = optional(string, null)
    instance_service_account = optional(object({
      email  = optional(string)
      scopes = optional(list(string))
    }), {})
    instance_shielded_instance_config = optional(object({
      enable_secure_boot          = optional(bool)
      enable_vtpm                 = optional(bool)
      enable_integrity_monitoring = optional(bool)
    }), {})
    instance_reservation_affinity = optional(list(object({
      type = string
      specific_reservation = optional(list(object({
        key    = string
        values = string
      })))
    })), [])
    instance_enable_confidential_compute = optional(bool, null)
    instance_advanced_machine_features = optional(list(object({
      enable_nested_virtualization = optional(bool)
      threads_per_core             = optional(number)
    })), [])
  }))
}