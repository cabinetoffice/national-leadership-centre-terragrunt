# terragrunt.hcl example
include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc",  ]
}



dependency "vpc" {
  config_path = "../vpc"
  # skip_outputs = true
  mock_outputs = {
  vpc_id = "temp-vpc_id"
  private_subnets = "temp-private_subnets"
  public_subnets = "temp-public_subnets"
  }
}

inputs = {

  vpc_id = dependency.vpc.outputs.vpc_id
  private_subnets = dependency.vpc.outputs.private_subnets
  public_subnets = dependency.vpc.outputs.public_subnets
  eks_worker_instance_type = "t2.large" 

  # what to call the cluster 
  cluster_name = "eks-for-testing-gsp"
  # where to put kubeconfig output
  write_kubeconfig = true
  # where to write kubeconfig - does not seem to be working 
  config_output_path = "/Users/tily/.kube/config"
}

terraform {
  source = "git::ssh://git@github.com/cabinetoffice/national-leadership-centre-terraform.git//eks"
}

