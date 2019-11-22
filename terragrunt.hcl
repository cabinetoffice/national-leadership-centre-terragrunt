# terragrunt.hcl example
remote_state {
  backend = "s3"
  config = {
    bucket         = "subatomic-dev-gsp-state-4"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "subatomic-tf-dev-gsp-lock-4"
  }
}

inputs = {
  aws_region = "eu-west-2"
}


