module "cert-manager" {
    depends_on = [module.eks]
    source = "git::https://github.com/Cjay13/terraform-kubernetes-cert-manager.git?ref=main"

    providers = {
        kubectl = kubectl
    }

    chart_version            = var.cert_manager_chart_version
    create_clusterIssuer     = var.create_clusterIssuer
    clusterIssuer_name       = var.cluster_issuer_name
    acme_server_url          = var.acme_server_url
    letsencrypt_email        = var.letsencrypt_email
    private_key_secret_name  = var.private_key_secret_name
    ingress_class            = var.ingress_class_name
}