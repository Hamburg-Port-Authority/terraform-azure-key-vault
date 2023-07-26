variable "name" {
  type        = string
  description = "Name of the Key Vault. Vault name must be between 3-24 alphanumeric characters. The name must begin with a letter, end with a letter or digit, and not contain consecutive hyphens."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group in which the Key Vault is created."
}

variable "sku_name" {
  type        = string
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium."
  default     = "standard"
}

variable "role_definition_name" {
  type        = string
  description = "The Scoped-ID of the Role Definition. Changing this forces a new resource to be created. Conflicts with role_definition_name"
  default     = "Key Vault Administrator"
}

variable "purge_procetion" {
  type        = bool
  description = "Purge protection is an optional feature of Azure Key Vault which is disabled by default. Purge protection can only be enabled once soft delete is enabled for the key vault. When purge protection is on, a vault or an object in the deleted state cannot be purged until the retention period has passed."
  default     = true
}

variable "enabled_for_template_deployment" {
  type        = bool
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
  default     = false
}

variable "enable_rbac_authorization" {
  type        = bool
  description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
  default     = false
}

variable "soft_delete_retention_days" {
  type        = number
  description = "The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days."
  default     = 7
}

variable "key_vault_admin_object_ids" {
  type        = list(string)
  description = "Optional list of object IDs of users or groups who should be Key Vault Administrators. Should only be set, if enable_rbac_authorization is set to true."
  default     = []
}

variable "certificate_permissions" {
  type        = list(string)
  description = "Optional list of permission"
  default = [
    "Get"
  ]
}

variable "key_permissions" {
  type        = list(string)
  description = "Optional list of permission"
  default = [
    "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"
  ]
}

variable "secret_permissions" {
  type        = list(string)
  description = "Optional list of permission"
  default = [
    "Get", "List", "Set", "Delete", "Recover", "Purge", "Restore", "Backup", "Update"
  ]
}

variable "storage_permissions" {
  type        = list(string)
  description = "Optional list of permission"
  default = [
    "Get"
  ]
}
variable "network_acls" {
  type = object({
    bypass                     = string,
    default_action             = string,
    ip_rules                   = list(string),
    virtual_network_subnet_ids = list(string),
  })

  description = "Object with attributes: `bypass`, `default_action`, `ip_rules`, `virtual_network_subnet_ids`. See https://www.terraform.io/docs/providers/azurerm/r/key_vault.html#bypass for more informations."
  default = {
    default_action             = "Deny"
    ip_rules                   = []
    bypass                     = "AzureServices"
    virtual_network_subnet_ids = []
  }
}

#granted_object_id is map of different ids like groups, service-principals, etc. in azure.
variable "granted_object_ids" {
  description = "A list of object_ids for AD groups or service principals is expected. Permissions to Secrets, Keys, Storage, Certificates are assigned to the IDs. "
  type        = map(string)
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Defines the default tags.  Some tags like owner are enforced by Azure policies. "
  default = {
    TF-Managed  = "true"
    TF-Worfklow = ""
    Maintainer  = ""
  }
}
