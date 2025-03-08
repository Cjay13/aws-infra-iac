variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-2"
}

variable "clusterName" {
  description = "EKS Cluster Name"
  type        = string
  default     = "ecom-eks"

}

variable "dbPassowrd" {
  description = "RDS password"
  type        = string
  default     = "admin123"
  sensitive   = true

}

##Test1



