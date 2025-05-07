module "argocd" {
    depends_on = [module.cert-manager]
    source = "git::https://github.com/Cjay13/terraform-k8s-argocd.git?ref=main"
    namespace = var.argocd_namespace
    enable_ingress = var.argocd_enable_ingress
    ingressClassName = var.ingress_class_name
    enable_tls = var.argocd_enable_tls
    domainName = var.argocd_domainName
    use_cluster_issuer = var.argocd_use_cluster_issuer
    clusterIssuer = module.cert-manager.cluster_issuer_name
}