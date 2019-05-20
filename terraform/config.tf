# AWS Profile Config
provider "aws" {
  region                  = "eu-west-1"
  profile                 = "tooploox-jaceks-task"
}

# Statefiles in S3
terraform {
backend "s3" {
    encrypt = true
    bucket = "jacekh-statefiles"
    key = "task/v2/terraform.tfstate"
    region = "eu-west-1"
}
}