# terragrunt.hcl for AWS RDS

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

  allocated_storage = 5
  major_engine_version    = "5.7"
  engine_version    = "5.7.22"
  vpc_id            = dependency.vpc.outputs.vpc_id
  private_subnet_cidr_blocks   = dependency.vpc.outputs.private_subnet_cidr_blocks
  public_subnet_cidr_blocks    = dependency.vpc.outputs.public_subnet_cidr_blocks
  database_subnet_cidr_blocks  = dependency.vpc.outputs.database_subnet_cidr_blocks
  private_subnets   = dependency.vpc.outputs.private_subnets
  public_subnets    = dependency.vpc.outputs.public_subnets
  database_subnets  = dependency.vpc.outputs.database_subnets
  # database_subnet_group    = dependency.vpc.outputs.database_subnet_group

  # can not get the export to work yet from vpc module ... :(
  # database_subnet_group    = "default-vpc-0eb6ba0ce1920de1e"
  #
  #'db_master_password' in terraform var file or command line pls 
  #'db_master_username' in terraform var file or command line pls 

  database_instance_class = "db.t3.medium"
  multi_az                = true

  # what to call the database instance 
  database_identifier = "nlc-prod"
  database_name       = "connect"

}

terraform {
  source = "git::ssh://git@github.com/cabinetoffice/national-leadership-centre-terraform.git//rds"
  #extra_arguments "common_vars" {
  #  commands = ["plan", "apply"]
  #  arguments = [
  #    "-var-file=rds.tfvars",
  #  ]
  #}
}

