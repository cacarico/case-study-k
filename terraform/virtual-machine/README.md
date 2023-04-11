## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.61.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_address.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_firewall.apache](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.ssh](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | The disk size for the instance | `number` | `20` | no |
| <a name="input_image"></a> [image](#input\_image) | Image name for the instance | `string` | `"centos-cloud/centos-7"` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Instance type | `string` | `"e2-micro"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for all resources | `string` | `"web-server"` | no |
| <a name="input_network"></a> [network](#input\_network) | Network name | `string` | `"default"` | no |
| <a name="input_ssh_ip"></a> [ssh\_ip](#input\_ssh\_ip) | The ip that is enabled to ss | `string` | `"0.0.0.0/0"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone to deploy the instance | `string` | `"europe-west3-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip"></a> [ip](#output\_ip) | n/a |
