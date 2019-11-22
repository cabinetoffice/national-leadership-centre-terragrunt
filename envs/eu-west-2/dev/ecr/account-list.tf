variable "account_list" {
  description = "List of all the accounts which have access to the repos"
  type        = "list"

  default = [
    # master account
    "arn:aws:iam::769722907362:root",
  ]
}
