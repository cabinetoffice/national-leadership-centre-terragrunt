# terragrunt.hcl 
include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc", ]
}


dependency "vpc" {
  config_path = "../vpc"
   mock_outputs = {
  vpc_id = "temp-vpc_id"
  private_subnets = "temp-private_subnets"
  public_subnets = "temp-public_subnets"
  }
}

  inputs = {
  # why is this not found in find_in_parent_folders
  aws_region = "eu-west-2"
    ecr_account_list = [
    "arn:aws:iam::844569024453:user/tily"
    ]
  
  ecr_repository_list = [
  "testrepo1",
  "testrepo2",
  ]
  }

terraform {
  source = "git::ssh://git@github.com/stutily/cv-terraform-eu-west-2.git//ecr"
}

