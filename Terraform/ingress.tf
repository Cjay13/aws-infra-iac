resource "helm_release" "nginx-ingress-controller" {
    name       = "ingress-nginx"
    repository = "https://kubernetes.github.io/ingress-nginx"
    chart      = "ingress-nginx"
    namespace  = "ingress-nginx"
    create_namespace = true

    set {
        name  = "controller.service.type"
        value = "LoadBalancer"
    }

    depends_on = [
    helm_release.karpenter
  ]
}