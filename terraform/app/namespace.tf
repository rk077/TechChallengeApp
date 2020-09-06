# Create namespace in the cluster
resource "kubernetes_namespace" "namespace" {
  metadata {
      name = "${var.namespace}"

    labels = {
      name = "${var.namespace}"
    }
  }
}
