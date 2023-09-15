vnets = {
  spoke_aks_re1 = {
    resource_group_key = "aks_re1"
    region             = "region1"
    vnet = {
      name          = "spoke1"
      address_space = ["100.64.48.0/22"]
    }
    specialsubnets = {}
    subnets = {
      aks_nodepool_system = {
        name                                           = "aks_nodepool_system"
        cidr                                           = ["100.64.48.0/24"]
        nsg_key                                        = "azure_kubernetes_cluster_nsg"
        enforce_private_link_endpoint_network_policies = true
      }
      backend = {
        name                                           = "backend"
        cidr                                           = ["100.64.49.0/24"]
        nsg_key                                        = "backend_nsg"
        enforce_private_link_endpoint_network_policies = true
      }
      db = {
        name                                            = "db"
        cidr                                            = ["100.64.50.0/24"]
        nsg_key                                         = "db_nsg"
        enforce_private_link_endpoint_network_policies  = true
        service_endpoints                               = ["Microsoft.Sql"] 
      }
    }
  }
}


network_security_group_definition = {
  empty_nsg = {}
  backend_nsg = {
    nsg = []
  }
  db_nsg = {
    nsg = [    
    {
        name                       = "sg-sql-in-allow",
        priority                   = "110"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "1433"
        destination_port_range     = "1433"
        source_address_prefix      = "100.64.49.0/24"
        destination_address_prefix = "100.64.50.0/24"
      },
      {
         name                       = "deny-default-in",
         priority                   = "1000"
         direction                  = "Inbound"
         access                     = "Deny"
         protocol                   = "*"
         source_port_range          = "*"
         destination_port_range     = "*"
         source_address_prefix      = "*"
         destination_address_prefix = "*"
      }
    ]
  }
  azure_kubernetes_cluster_nsg = {
    nsg = [
      {
        name                       = "aks-http-in-allow",
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "aks-https-in-allow",
        priority                   = "110"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "aks-api-out-allow-1194",
        priority                   = "100"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Udp"
        source_port_range          = "*"
        destination_port_range     = "1194"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
      },
      {
        name                       = "aks-api-out-allow-9000",
        priority                   = "110"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "9000"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
      },
      {
        name                       = "aks-ntp-out-allow",
        priority                   = "120"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Udp"
        source_port_range          = "*"
        destination_port_range     = "123"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "aks-https-out-allow-443",
        priority                   = "130"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
    ]
  }
}