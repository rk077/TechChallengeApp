# Db config Secrets
resource "kubernetes_secret" "db-config" {
  metadata {
    name = "db-config"
    namespace = "${kubernetes_namespace.namespace.metadata[0].name}"
  }

  data = {
    "db-conf.toml" = "${file(var.app-config)}"
  }

  type = "Opaque"
}


# Cloudsql Secret
resource "kubernetes_secret" "cloudsql-instance-credentials" {
  metadata {
    name = "cloudsql-instance-credentials"
    namespace = "${kubernetes_namespace.namespace.metadata[0].name}"
  }

  data = {
    "cloud-sql-sa.json" = "${file(var.sa-cloud-sql)}"
  }

  type = "Opaque"
}
