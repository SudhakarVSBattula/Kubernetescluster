resource "azurerm_resource_group" "akskubergref" {
  name     = "akskuberg"
  location = "East US"
}
# Creating Azure Container Registry inside resource group
resource "azurerm_container_registry" "acraksref" {
  name                = "acrakscontainer1590"
  resource_group_name = azurerm_resource_group.akskubergref.name
  location            = azurerm_resource_group.akskubergref.location
  sku                 = "Basic"
}
# Creating Kubernetes Cluster inside resource group
resource "azurerm_kubernetes_cluster" "aksclusterref" {
  name                = "aksclustr"
  location            = azurerm_resource_group.akskubergref.location
  resource_group_name = azurerm_resource_group.akskubergref.name
  dns_prefix          = "aksclustr"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

}
# this resource is for attaching acr to aks
resource "azurerm_role_assignment" "acraksrbacref" {
  principal_id                     = azurerm_kubernetes_cluster.aksclusterref.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acraksref.id
  skip_service_principal_aad_check = true
}