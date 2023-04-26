# main.tf

resource "aws_s3_bucket" "this" {
  bucket = local.name
  #checkov:skip=CKV_AWS_144:This bucket does not require cross region replication.
  #checkov:skip=CKV_AWS_145:This bucket is encrypted with default aws kms key.
  #checkov:skip=CKV2_AWS_61:This bucket does not require lifecycle policy.
  #checkov:skip=CKV2_AWS_62:This bucket does not require notifications.
}

resource "aws_s3_bucket_acl" "this" {
  count  = var.acl_enabled ? 1 : 0
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

resource "aws_s3_bucket_logging" "this" {
  count         = var.access_logging_target_bucket != null ? 1 : 0
  bucket        = aws_s3_bucket.this.id
  target_bucket = var.access_logging_target_bucket
  target_prefix = "${aws_s3_bucket.this.id}/"
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Deny"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:*",
    ]

    resources = [
      "${aws_s3_bucket.this.arn}/*",
      "${aws_s3_bucket.this.arn}"
    ]

    condition {
      test     = "Bool"
      values   = ["false"]
      variable = "aws:SecureTransport"
    }
  }
}