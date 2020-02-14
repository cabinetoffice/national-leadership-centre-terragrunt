terraform {
  source = "git::ssh://git@github.com/cabinetoffice/national-leadership-centre-terraform.git//acm"
}

include {
  path = find_in_parent_folders()
}

inputs = {
   connect_production_domain_name = "connect.nationalleadership.gov.uk"
   # connect_staging_domain_name = "???"
}
