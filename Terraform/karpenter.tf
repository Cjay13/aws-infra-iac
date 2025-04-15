module "karpenter" {
  source = "terraform-aws-modules/eks/aws//modules/karpenter"

  cluster_name = module.eks.cluster_name

  enable_v1_permissions = true
  
  enable_pod_identity = true
  create_pod_identity_association = true

  # Attach additional IAM policies to the Karpenter node IAM role
  node_iam_role_additional_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}


resource "helm_release" "karpenter" {
  namespace = "kube-system"
  name = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart = "karpenter"
  version = "1.0.0"
  wait = false

  values = [
    <<-EOT
    serviceAccount:
      name: ${module.karpenter.service_account}
    settings:
      clusterName: ${module.eks.cluster_name}
      clusterEndpoint: ${module.eks.cluster_endpoint}
      interruptionQueue: ${module.karpenter.queue_name}
    EOT
  ]

}

# Nodepool Configuration

resource "kubectl_manifest" "karpenter-node-pool" {
  yaml_body = <<-YAML
    apiVersion: karpenter.sh/v1beta1
    kind: NodePool
    metadata:
      name: default-node-pool
    spec:
      template:
        spec:
          nodeClassRef:
            name: default-node-class
          requirements:
            - key: "karpenter.k8s.aws/instance-type"
              operator: In
              values: ["t3.small"]
            - key: "karpenter.k8s.aws/capacity-type"
              operator: In
              values: ["spot"]
 
      limits:
        cpu: 100
      disruption:
        consolidationPolicy: WhenEmpty
        consolidateAfter: 30s
      
  YAML

  depends_on = [
    kubectl_manifest.karpenter_node_class
  ]
}

resource "kubectl_manifest" "karpenter_node_class" {
  yaml_body = <<-YAML
    apiVersion: karpenter.k8s.aws/v1beta1
    kind: EC2NodeClass
    metadata:
      name: default-node-class
    spec:
     role: ${module.karpenter.node_iam_role_name}
     amiFamily: AL2
     subnetSelectorTerms:
        - tags:
            karpenter.sh/discovery: ${module.eks.cluster_name}
     securityGroupSelectorTerms:
        - tags:
            karpenter.sh/discovery: ${module.eks.cluster_name}
     tags:
        karpenter.sh/discovery: ${module.eks.cluster_name}
  YAML

  depends_on = [
    helm_release.karpenter
  ]
}
