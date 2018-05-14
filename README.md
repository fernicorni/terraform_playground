# terraform_playground
Playing around with terraform.

Creates a VPC with 2 subnets (one public, one private).
Creates a couple of EC2 instances, one will act as a bridge to get to the other. 

## How-to generate infra
terraform apply -var-file=variables.tfvars

