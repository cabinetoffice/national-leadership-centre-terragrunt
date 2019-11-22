terraform {
  source = "git::ssh://git@github.com/stutily/cv-tf.git//vpc"
}

include {
  path = find_in_parent_folders()
}


inputs = {
  vpc_name = "eu-west-2-vpc-1"
  }


