# S3 Access Logging Enabled Example

## Usage 

```terraform
module "compliant_s3_bucket" {
  source                       = "andyscott1547/compliant_s3_bucket/aws"
  version                      = "0.1.1"
  name                         = "example"
  access_logging_target_bucket = "central-logging-bucket"
}
```

## Terraform Docs

<!-- BEGIN_TF_DOCS -->
#### Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 4.0 |

#### Providers

No providers.

#### Modules

| Name | Source | Version |
|------|--------|---------|
| tf_state | andyscott1547/remote-state/aws | 1.1.0 |

#### Resources

No resources.

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | value for the region | `string` | `"eu-west-1"` | no |
| tags | value for the tags | `map(string)` | `{}` | no |

#### Outputs

No outputs.
<!-- END_TF_DOCS -->