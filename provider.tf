provider "aws" {
  region              = "ap-northeast-2"
  version             = "~> 2.7"
  profile             = "jihyun"
  allowed_account_ids = "${var.allowed_account_ids}"
  # forbidden_account_ids = "${var.forbidden_account_ids}"
  # access_key            = "${var.aws_access_key}"
  # secret_key            = "${var.aws_secret_key}"
}

provider "aws" {
  alias               = "us_east_1"
  region              = "us-east-1"
  version             = "~> 2.7"
  profile             = "jihyun"
  allowed_account_ids = "${var.allowed_account_ids}"
}

terraform {
  required_version = ">= 0.12.7"
  backend "s3" {
    bucket  = "jihyun-terraform-state-bucket"
    key     = "terraform.tfstate"
    region  = "ap-northeast-2"
    profile = "jihyun"
  }
}
