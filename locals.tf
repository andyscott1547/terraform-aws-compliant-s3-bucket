# locals.terraform

locals {
  name = "${var.bucket_name}-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
}