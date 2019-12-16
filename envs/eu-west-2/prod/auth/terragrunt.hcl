# terragrunt.hcl - authentication roles

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc", "../eks" ]
  #paths = ["../eks" ]
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id          = "temp-vpc_id"
    private_subnets = "temp-private_subnets"
    public_subnets  = "temp-public_subnets"
  }
}

dependency "eks" {
  config_path = "../eks"
  mock_outputs = {
    cluster_arn  = "temp-cluster_arn"
  }
}

inputs = {
  #vpc_id                  = dependency.vpc.outputs.vpc_id
  cluster_arn             = dependency.eks.outputs.cluster_arn
}

terraform {
  source = "git::ssh://git@github.com/cabinetoffice/national-leadership-centre-terraform.git//auth"
}

