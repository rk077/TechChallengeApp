#####################################################################
# Enable this block if default subnet does not already exist
# VPC network config
#####################################################################
#resource "google_compute_network" "vpc_network" {
#  name                    = "default"
#  auto_create_subnetworks = "true"
#}

#####################################################################
# GKE Cluster
#####################################################################
resource "google_container_cluster" "gkecluster" {
  name               = "${var.cluster}"
  location           = "${var.zone}"
  initial_node_count = 1
  remove_default_node_pool = true
  //depends_on = [google_compute_network.vpc_network]  //Explicit dependency on VPC network

  master_auth {
    username = "${var.username}"
    password = "${var.password}"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/compute",
    ]
  }
}

#####################################################################
# App Node Pool
#####################################################################
resource "google_container_node_pool" "app_node" {
  name       = "${var.app_pool}"
  location   = "${var.zone}"
  cluster    = google_container_cluster.gkecluster.name
  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "n1-standard-4"

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/compute",
    ]
  }
}
