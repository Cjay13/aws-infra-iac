variable "region" {
    description = "AWS Region"
    type = string
    default = "us-east-1"
}

variable "clusterName" {
    description = "EKS Cluster Name"
    type = string
    default = "ecom-eks"

}

