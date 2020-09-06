# App Deployment
resource "kubernetes_deployment" "app_deployment" {
  metadata {
    name      = "app-deployment"
    namespace = "${kubernetes_namespace.namespace.metadata[0].name}"

    labels = {
      app = "todo-app"

      tier = "app"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "todo-app"

        tier = "app"
      }
    }

    template {
      metadata {
        labels = {
          app = "todo-app"

          tier = "app"
        }
      }

      spec {

        volume {
          name = "database-config"

          secret {
            secret_name = "db-config"

            items {
              key  = "db-conf.toml"
              path = "conf.toml"
            }

            default_mode = "0644"
          }
        }

        volume {
          name = "cloudsql-instance-service-account"

          secret {
            secret_name = "cloudsql-instance-credentials"

            items {
              key  = "cloud-sql-sa.json"
              path = "credentials.json"
            }

            default_mode = "0644"
          }
        }

        volume {
          name = "cloudsql"
        }


        container {
          name  = "app"
          image = "${var.app_image}"

          port {
            container_port = 3000
            protocol       = "TCP"
          }

          volume_mount {
            name       = "database-config"
            read_only  = true
            mount_path = "/conf.toml"
            sub_path   = "conf.toml"
          }


          readiness_probe {
            http_get {
              path = "/check"
              port = "3000"
            }

            initial_delay_seconds = 5
            period_seconds        = 5
            failure_threshold     = 20
          }

          image_pull_policy = "Always"
        }

        container {
          name    = "cloudsql-proxy"
          image   = "gcr.io/cloudsql-docker/gce-proxy:1.09"
          command = ["/cloud_sql_proxy", "--dir=/cloudsql", "-instances=${var.cloud_sql_instance_name}", "-credential_file=/secrets/cloudsql/credentials.json"]

          volume_mount {
            name       = "cloudsql-instance-service-account"
            read_only  = true
            mount_path = "/secrets/cloudsql"
          }

          volume_mount {
            name       = "cloudsql"
            mount_path = "/cloudsql"
          }

          image_pull_policy = "IfNotPresent"
        }

        restart_policy = "Always"

        node_selector = {
          "cloud.google.com/gke-nodepool" = "${var.app_pool}"
        }
      }
    }

    strategy {
      type = "RollingUpdate"

      rolling_update {
        max_unavailable = "25%"
        max_surge       = "25%"
      }
    }

    revision_history_limit = 2
  }
}
