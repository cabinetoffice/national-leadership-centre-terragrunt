# terragrunt.hcl for AWS ES

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
    vpc_id           = "temp-vpc_id"
    private_subnets  = "temp-private_subnets"
    public_subnets   = "temp-public_subnets"
    database_subnets = "temp-database_subnets"
  }
}

inputs = {
  es_version = "6.8" 
  es_instance_type = "t2.small.elasticsearch" 
  es_instance_count = 3
  es_dedicated_master_type = "t2.small.elasticsearch"
  es_dedicated_master_threshold = 0
  es_domain_name = "es-connect"
  vpc_id            = dependency.vpc.outputs.vpc_id
  private_subnet_cidr_blocks   = dependency.vpc.outputs.private_subnet_cidr_blocks
  public_subnet_cidr_blocks    = dependency.vpc.outputs.public_subnet_cidr_blocks
  private_subnets   = dependency.vpc.outputs.private_subnets
  public_subnets    = dependency.vpc.outputs.public_subnets
}

terraform {
  source = "git::ssh://git@github.com/cabinetoffice/national-leadership-centre-terraform.git//es"
}

