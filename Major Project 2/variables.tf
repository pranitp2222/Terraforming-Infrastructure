variable "imageid" {}
variable "instance-type" {}
variable "key-name" {}
variable "vpc_security_group_ids" {}
variable "cnt" {}
variable "install-env-file" {}
variable "az" { default = ["us-east-2a", "us-east2b", "us-east-2c"] }
variable "elb-name" {}
variable "tg-name" {}
variable "asg-name" {}
variable "lt-name" {}
variable "db-name" {}
variable "db-name-rpl" {}
variable "min" { default = 2 }
variable "max" { default = 5 }
variable "desired" { default = 3 }
variable "iam-profile" {}
variable "sns-topic" {}
variable "dynamodb-table-name" {}
variable "raw-s3-bucket" {}
variable "finished-s3-bucket" {}