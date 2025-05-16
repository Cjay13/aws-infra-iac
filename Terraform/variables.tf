variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-2"
}

variable "clusterName" {
  description = "EKS Cluster Name"
  type        = string
  default     = "cjay-devops-eks"
}

variable "create_clusterIssuer" {
  description = "Whether to create a clusterIssuer or not"
  type = bool
  default = true
}

variable "cluster_issuer_name" {
  description = "Name of the clusterIssuer"
  type = string
  default = "letsencrypt-prod"
}

variable "cert_manager_chart_version" {
  description = "cert-manager helm chart version"
  type = string
  default = "v1.17.0"
}

variable "acme_server_url" {
  description = "ACME acme server URL"
  type = string
  default = "https://acme-v02.api.letsencrypt.org/directory"
}

variable "letsencrypt_email" {
  description = "Email used for letsencrypt"
  type = string
  default = "herath.charithjay@gmail.com"
}

variable "private_key_secret_name" {
  description = "Secret to store ACME account private key"
  type = string
  default = "letsencrypt-prod"
}

variable "ingress_class_name" {
  description = "Name of the ingressClass"
  type = string
  default = "nginx"
}

variable "argocd_namespace" {
  description = "Namespace where argocd will be installed"
  type = string
  default = "argocd"
}

variable "argocd_domainName" {
  description = "Doamin name for argocd ui"
  type = string
  default = "argocd.cjaydevops.com"
}

variable "argocd_enable_ingress" {
  description = "Whether to enable ingress for argocd or not"
  type = bool
  default = true
}

variable "argocd_enable_tls" {
  description = "Whether to enable TLS termination at ingress for argocd or not"
  type = bool
  default = true
}

variable "argocd_use_cluster_issuer" {
  description = "Whether to use clusterIssuer or Issuer for TLS termination"
  type = bool
  default = true
}



