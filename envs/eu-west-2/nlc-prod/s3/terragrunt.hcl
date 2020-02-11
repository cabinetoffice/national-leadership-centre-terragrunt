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
  s3fs_bucket_name            = "nlc-static-prod"
  s3fs_bucket_name_staging    = "nlc-static-staging"
  semver_bucket_name          = "nlc-concourse-semver"
}

terraform {
  source = "git::ssh://git@github.com/cabinetoffice/national-leadership-centre-terraform.git//s3"
}

