terraform {
  backend "gcs" {
    bucket = "tf-state-dev-001"
  }
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.75.1"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.75.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
  required_version = ">= 1.4.2"
}