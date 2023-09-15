terraform {
  backend "azurerm" {}
  required_providers {
  }
  required_version = ">= 1.4.0"
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  alias = "vhub"
}

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.7.3"

  providers = {
    azurerm.vhub = azurerm.vhub
  }
  preview_features = var.preview_features
  diagnostics = {
    diagnostic_log_analytics = var.diagnostic_log_analytics
    diagnostic_storage_accounts = var.diagnostic_storage_accounts
  }
  azuread = {
    azuread_groups = var.azuread_groups
  }
  managed_identities = var.managed_identities


  global_settings = var.global_settings
  resource_groups = var.resource_groups
  
  keyvaults       = var.keyvaults
  
  storage_accounts = var.storage_accounts
  database = {
    mssql_servers = var.mssql_servers
    mssql_databases = var.mssql_databases
  }
  
  compute = {
    aks_clusters = var.aks_clusters
    azure_container_registries = var.azure_container_registries
  }

  networking = {
    public_ip_addresses = var.public_ip_addresses
    vnets               = var.vnets
    network_security_group_definition = var.network_security_group_definition
    private_dns = var.private_dns
  }
}