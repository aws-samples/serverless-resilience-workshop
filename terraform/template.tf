terraform {
  required_version = ">= 0.12"
}

provider "aws" {
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "random_id" "chaos_stack" {
  byte_length = 8
}