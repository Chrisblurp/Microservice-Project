output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.microservices.name
}

output "location" {
  description = "Azure region"
  value       = var.location
}

output "container_registry_name" {
  description = "Name of the Azure Container Registry"
  value       = azurerm_container_registry.microservices.name
}

output "container_registry_login_server" {
  description = "Login server URL for the container registry"
  value       = azurerm_container_registry.microservices.login_server
}

output "aks_cluster_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.microservices.name
}

output "aks_cluster_endpoint" {
  description = "Endpoint for the AKS cluster API server"
  value       = azurerm_kubernetes_cluster.microservices.kube_config.0.host
  sensitive   = true
}

output "postgres_host" {
  description = "PostgreSQL server hostname"
  value       = azurerm_postgresql_flexible_server.microservices.fqdn
}

output "postgres_database" {
  description = "PostgreSQL database name"
  value       = azurerm_postgresql_flexible_server_database.microservices.name
}

output "redis_host" {
  description = "Redis cache hostname"
  value       = azurerm_redis_cache.microservices.hostname
}

output "deployment_summary" {
  description = "Summary of deployed resources"
  value = {
    resource_group     = azurerm_resource_group.microservices.name
    location           = var.location
    aks_cluster        = azurerm_kubernetes_cluster.microservices.name
    container_registry = azurerm_container_registry.microservices.name
    postgres_server    = azurerm_postgresql_flexible_server.microservices.name
    redis_cache        = azurerm_redis_cache.microservices.name
  }
}
