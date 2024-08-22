locals {
  default_tags = merge(var.default_tags, { "Environment" = "${terraform.workspace}" })
  environment  = terraform.workspace != "default" ? terraform.workspace : ""
}