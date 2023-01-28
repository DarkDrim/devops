resource "kubernetes_deployment_v1" "app1" {
  metadata {
    name = "app1"
    labels = {
      App = "App1"
    }
  }

  spec {
    replicas = 4
    selector {
      match_labels = {
        App = "App1"
      }
    }
    template {
      metadata {
        labels = {
          App = "App1"
        }
      }
      spec {
        container {
          image = "drim/devops:1.0.1"
          name  = "app1"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.2"
              memory = "128Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "app1" {
  metadata {
    name = "app1"
  }
  spec {
    selector = {
      App = kubernetes_deployment_v1.app1.spec.0.template.0.metadata[0].labels.App
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 80
    }
  }
}
