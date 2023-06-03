# Example for the module

```sh
terraform init

terraform plan -var region=${AWS_REGION}
terraform plan -var region=${AWS_REGION} -var prefix=example

terraform apply -var region=${AWS_REGION}
```
