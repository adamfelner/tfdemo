keyvaults = {
  aks = {
    name                = "aks_akv"
    resource_group_key  = "aks_re1"
    sku_name            = "standard"
    soft_delete_enabled = true

    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
    diagnostic_profiles = {
    }
  }
}