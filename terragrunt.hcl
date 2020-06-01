remote_state {
  backend = "s3"
  config = {
    bucket         = "nlc-infrastructure-tfstate"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "nlc-infrastructure-tfstate"
  }
}

inputs = {
  aws_profile = "nlc"
  aws_region = "eu-west-2"
}
