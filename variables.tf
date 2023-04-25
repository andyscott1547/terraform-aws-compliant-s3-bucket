# variables.tf

variable "bucket_name" {
  description = "Prefix of the S3 bucket name"
  type        = string
}

variable "access_logging_target_bucket" {
  description = "Name of logging bukcet used for s3 access logging"
  type        = string
  default     = null
}

variable "acl_enabled" {
  description = "Enable ACL on the bucket"
  type        = bool
  default     = false
}