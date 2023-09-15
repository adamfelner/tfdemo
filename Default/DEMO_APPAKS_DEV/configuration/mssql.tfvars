mssql_servers = {
  sales_sql_re1 = {
    name                = "sales_sql_re1"
    region              = "region1"
    resource_group_key  = "aks_re1"
    version             = "12.0"
    administrator_login = "sqlsalesadmin"
    keyvault_key                  = "aks"
    connection_policy             = "Default"
    system_msi                    = true
    public_network_access_enabled = false
    tags = {
      segment = "sales"
    }
    firewall_rules = {
    }
    network_rules = {
    }
    private_dns_zone = {
      key = "dns1"
    }
    private_endpoints = {
        private-link-level4 = {
          name       = "sales-sql-rg1"
          vnet_key   = "spoke_aks_re1"
          subnet_key = "db"
          resource_group_key = "aks_re1"
          private_service_connection = {
            name                 = "sales-sql-rg1"
            is_manual_connection = false
            subresource_names    = ["sqlServer"]
          }
        }
     }
  }
}
mssql_databases = {
  mssql_db1 = {
    name               = "exampledb1"
    resource_group_key = "aks_re1"
    mssql_server_key   = "sales_sql_re1"
    license_type       = "LicenseIncluded"
    max_size_gb        = 4
    sku_name           = "BC_Gen5_2"
  }
}

private_dns = {
  dns1 = {
    name               = "mssqlexample.privatelink.database.azure.com"
    resource_group_key = "aks_re1"

    records = {
      a_records = {
        sql-salessqlre1 = {
          name    = "sql-salessqlre1"
          ttl     = 3600
          records = ["100.64.50.4"]
          tags = {
            resource = "a_records"
          }
        }
      }
    }
    vnet_links = {
      vnlk1 = {
        name     = "sql-vnet-link"
        vnet_key = "spoke_aks_re1"
      }
    }

  }
}
