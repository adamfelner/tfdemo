preview_features = {
}
aks_clusters = {
  cluster_re1 = {
    name               = "akscluster-001"
    resource_group_key = "aks_re1"
    os_type            = "Linux"
    identity = {
      type = "SystemAssigned"
    }

    vnet_key = "spoke_aks_re1"

    network_policy = {
      network_plugin    = "azure"
      load_balancer_sku = "standard"
    }

    private_cluster_enabled = false
    enable_rbac             = true
    outbound_type           = "userDefinedRouting"

    admin_groups = {
    }
    private_cluster_public_fqdn_enabled = true
    load_balancer_profile = {
      managed_outbound_ip_count = 1
    }

    private_endpoints = {
      pe1 = {
        name = "aks-pe"
        vnet_key   = "spoke_devops_re1"
        subnet_key = "private_endpoints"
        private_service_connection = {
          name                 = "aks-psc"
          is_manual_connection = false
          subresource_names    = ["management"]
        }
      }
    }

    default_node_pool = {
      name                  = "sharedsvc"
      vm_size               = "Standard_DS2_v2"
      subnet_key            = "aks_nodepool_system"
      enabled_auto_scaling  = false
      enable_node_public_ip = false
      max_pods              = 30
      node_count            = 2
      os_disk_size_gb       = 32
      tags = {
        "project" = "system services"
      }
    }

    node_resource_group_name = "aks-nodes-re1"

    node_pools = {
      pool1 = {
        name                = "nodepool1"
        mode                = "User"
        subnet_key          = "backend"
        max_pods            = 30
        vm_size             = "Standard_DS2_v2"
        node_count          = 2
        enable_auto_scaling = false
        os_disk_size_gb     = 32
        tags = {
          "project" = "user services"
        }
      }
    }

  }
}