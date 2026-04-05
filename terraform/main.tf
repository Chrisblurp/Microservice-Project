# Resource Group
resource "azurerm_resource_group" "microservices" {
  name     = "microservices-platform-rg"
  location = var.location

  tags = var.tags
}

# Random suffix for unique names
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Azure Container Registry
resource "azurerm_container_registry" "microservices" {
  name                = "microservices${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.microservices.name
  location            = azurerm_resource_group.microservices.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = var.tags
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "microservices" {
  name                = "microservices-aks"
  location            = azurerm_resource_group.microservices.location
  resource_group_name = azurerm_resource_group.microservices.name
  dns_prefix          = "microservices"

  default_node_pool {
    name            = "default"
    node_count      = var.aks_node_count
    vm_size         = var.aks_vm_size
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  role_based_access_control_enabled = true

  tags = var.tags
}

# PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server" "microservices" {
  name                   = "microservices-pg-${random_string.suffix.result}"
  resource_group_name    = azurerm_resource_group.microservices.name
  location               = azurerm_resource_group.microservices.location
  version                = "15"
  administrator_login    = "microservices_admin"
  administrator_password = random_password.postgres_password.result
  storage_mb             = 32768
  sku_name               = var.postgres_sku

  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "microservices" {
  name      = "microservices_db"
  server_id = azurerm_postgresql_flexible_server.microservices.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}

# Redis Cache
resource "azurerm_redis_cache" "microservices" {
  name                 = "microservices-redis-${random_string.suffix.result}"
  location             = azurerm_resource_group.microservices.location
  resource_group_name  = azurerm_resource_group.microservices.name
  capacity             = var.redis_capacity
  family               = "C"
  sku_name             = "Basic"
  non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"

  redis_configuration {
  }

  tags = var.tags
}

# Random password for PostgreSQL
resource "random_password" "postgres_password" {
  length      = 20
  special     = false
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
}
