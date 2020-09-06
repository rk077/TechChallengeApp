# App Service
resource "kubernetes_service" "app_service" {
  metadata {
    name      = "app-service"
    namespace = "${kubernetes_namespace.namespace.metadata[0].name}"

    labels = {
      app = "todo-app"

      tier = "app"
    }
  }

  spec {
    port {
      protocol    = "TCP"
      port        = 3000
      target_port = ${var.app_listen_port}
    }

    selector = {
      app = "todo-app"

      tier = "app"
    }

    type = "ClusterIP"
  }
}
