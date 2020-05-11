# terragrunt.hcl for AWS EKS cluster

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc", ]
}

dependency "vpc" {
  config_path = "../vpc"
  # skip_outputs = true
  mock_outputs = {
    vpc_id          = "temp-vpc_id"
    private_subnets = "temp-private_subnets"
    public_subnets  = "temp-public_subnets"
  }
}

inputs = {

  vpc_id                   = dependency.vpc.outputs.vpc_id
  private_subnets          = dependency.vpc.outputs.private_subnets
  public_subnets           = dependency.vpc.outputs.public_subnets
  eks_worker_instance_type = "t3.large"

  # what to call the cluster 
  cluster_name = "nlc-prod"
  cluster_version = "1.14"
  ami_id = "ami-0726488afbd16de79"

  # whether to write kubeconfig file  (default true)
  write_kubeconfig = true

  # where to write kubeconfig file
  config_output_path = "${get_env("HOME", ".")}/.kube/"

  # whether to manage aws auth or not 
  # and the roles, users, and accounts to add
  manage_aws_auth = true 

  map_roles = []
  map_accounts = []
  map_users = [
    {
      userarn  = "arn:aws:iam::***REMOVED***:user/mike.bell",
      username = "mike.bell"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::***REMOVED***:user/stu.tily",
      username = "stu.tily"
      groups   = ["system:masters"]
    }
  ]
}

terraform {
  source = "git::ssh://git@github.com/cabinetoffice/national-leadership-centre-terraform.git//eks"
}

