# Introduction:

The module is used to deploy azure key vaults over terraform with a default setup (Infrastructure as Code).

# Exmaple Use of Modul:

    module "key_vault" {
    source              = "github.com/la-cc/terraform-azure-key-vault?ref=1.0.0"

    name                = var.name
    resource_group_name = var.resource_group_name
    network_acls        = var.network_acls
    granted_object_ids  = var.granted_object_ids

    }
