# Introduction:

The module is used to deploy azure key vaults over terraform with a default setup (Infrastructure as Code).

> **_NOTE:_** The required providers, providers configuration and terraform version are maintained in the user's configuration and are not maintained in the modules themselves.

# Example Use of Module:

    module "key_vault" {
    source              = "github.com/Hamburg-Port-Authority/terraform-azure-key-vault?ref=1.0.1"

    name                = var.name
    resource_group_name = var.resource_group_name
    network_acls        = var.network_acls
    granted_object_ids  = var.granted_object_ids

    }
