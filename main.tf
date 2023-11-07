resource "azurerm_key_vault" "main" {
  name                            = var.name
  location                        = data.azurerm_resource_group.main.location
  resource_group_name             = data.azurerm_resource_group.main.name
  sku_name                        = var.sku_name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_procetion
  tags                            = var.tags

  dynamic "network_acls" {
    for_each = var.network_acls == null ? [] : [var.network_acls]
    iterator = acl

    content {
      bypass                     = coalesce(acl.value.bypass, "None")
      default_action             = coalesce(acl.value.default_action, "Deny")
      ip_rules                   = acl.value.ip_rules
      virtual_network_subnet_ids = acl.value.virtual_network_subnet_ids
    }
  }

}

resource "azurerm_role_assignment" "main" {
  for_each = var.enable_rbac_authorization == true ? toset(var.key_vault_admin_object_ids) : toset([])

  scope                = azurerm_key_vault.main.id
  role_definition_name = var.role_definition_name
  principal_id         = each.value
}

resource "azurerm_key_vault_access_policy" "grant_access_policy" {
  for_each     = var.granted_object_ids
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.value

  certificate_permissions = var.enable_certificates_permission ? var.full_certificate_permissions : []
  key_permissions         = var.enable_keys_permission ? var.full_key_permissions : []
  secret_permissions      = var.enable_secrets_permission ? var.full_secret_permissions : []
  storage_permissions     = var.storage_permissions
}
