# Terragrunt configurations.

[Terragrunt](https://github.com/gruntwork-io/terragrunt) configurations for setting up VPC and EKS. Use in parallel with the [cv-tf](https://github.com/cabinetoffice/national-leadership-centre-terraform) repo

Usage: 

  - change into the directory for your configs (or create a new one) and configure the remote state location and lockfile in terragtunr.hcl
  - run `terragrunt plan-all` to show what changes will be made
  - the repo configured in the terragrunt.hcl file will be pulled (if needed) and applied. 
  
  
Note - for local use, the repo will not be pulled again if it exists - so use local sources instead. For local developement use without pulling the git repos there is a helper script `tgl` which can be configured with a `.tgl` file in each path that you will run the `tgl` command from which speficies where the local sources are - this saves typing the path each time as `terragrunt plan --terragrunt-source /Where/My/Local/Terraform/Source/Is/` - for example 

```
$ pwd
/Users/tily/dev/convivio/tg/envs/eu-west-2/dev/vpc
$ cat .tgl
/Users/tily/dev/convivio/tf/vpc/
$ which tgl
/Users/tily/bin/tgl
$ tgl plan
running terragrunt plan --terragrunt-source /Users/tily/dev/convivio/tf/vpc/
[terragrunt] 2019/11/22 10:27:12 Reading Terragrunt config file at /Users/tily/dev/convivio/tg/envs/eu-west-2/dev/vpc/terragrunt.hcl
[terragrunt] [/Users/tily/dev/convivio/tg/envs/eu-west-2/dev/vpc] 2019/11/22 10:27:12 Running command: terraform --version

```

