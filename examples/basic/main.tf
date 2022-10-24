# examples/basic/main.tf

module "compliant_s3_bucket" {
  source  = "andyscott1547/compliant_s3_bucket/aws"
  version = "0.1.1"
  name    = "example"
}

