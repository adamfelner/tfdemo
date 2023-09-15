global_settings = {
  default_region = "region1"
  prefix = ""
  regions = {
    region1 = "northeurope"
    region2 = "westeurope"
  }
  inherit_tags = true
  tags = {
    example   = "DEMO_APPAKS_DEV"
  }
}


resource_groups = {
  aks_re1 = {
    name   = "aks-re1"
    region = "region1"
  }
}

role_mapping = {
  custom_role_mapping = {}

  built_in_role_mapping = {
    aks_clusters = {
      cluster_re1 = {
        "Azure Kubernetes Service Cluster Admin Role" = {
          logged_in = {
            keys = ["user"]
          }
          managed_identities = {
            keys = ["jumpbox"]
          }
        }
      }
    }
  }
}