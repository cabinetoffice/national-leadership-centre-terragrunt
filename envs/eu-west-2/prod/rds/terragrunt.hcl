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
    vpc_id          = "temp-vpc_id"
    private_subnets = "temp-private_subnets"
    public_subnets  = "temp-public_subnets"
    database_subnets  = "temp-database_subnets"
  }
}

inputs = {

  vpc_name                 = "eu-west-2-vpc-prod"
  allocated_storage        = 10
  vpc_id                   = dependency.vpc.outputs.vpc_id
  private_subnets          = dependency.vpc.outputs.private_subnets
  public_subnets           = dependency.vpc.outputs.public_subnets
  database_subnets         = dependency.vpc.outputs.database_subnets
  # database_subnet_group  = dependency.vpc.outputs.database_subnet_group
  # can not get the export to work yet from vpc module ... :(
  database_subnet_group    = "default-vpc-0eb6ba0ce1920de1e"
  db_master_password       = "xxx"
  db_master_username       = "xxx"

  database_instance_type   = "db.t3.small"
  multi_az                 = false

  # what to call the database instance 
  db_instance_name = "connedt-prod"
}

terraform {
  source = "git::ssh://git@github.com/cabinetoffice/national-leadership-centre-terraform.git//rds"
}

