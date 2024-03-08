# Ecom_AWS_IAC

This setup automates the provisioning of an Amazon Elastic Kubernetes Service (EKS) cluster and a Relational Database Service (RDS) instance within a custom Virtual Private Cloud (VPC) using Terraform. By integrating with GitHub Actions, resource provisioning and management become seamless and automated. This ensures consistency, reliability, and scalability in the deployment process, allowing for efficient development and operation of cloud-native applications. 

In this setup, the repository contains two main branches: main and stage. When changes are pushed to the stage branch, GitHub Actions is triggered to execute a Terraform plan. This plan generates an output, which is saved to a file named planfile.

After the Terraform plan output is reviewed and verified without any issues, the changes are merged into the main branch. This action triggers GitHub Actions again, initiating the application of Terraform changes based on the approved plan.

By following this workflow, changes are first tested in the staging environment (stage branch) before being applied to the production environment (main branch). This ensures that only verified and approved changes are deployed to the main infrastructure, enhancing stability and reliability of the system.
