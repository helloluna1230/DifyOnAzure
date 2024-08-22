# Required for the az_aks module to specify the aks subnet.
output "subnet_ids" {
  value = {
    for subnet in var.subnets :
    subnet.name => azurerm_subnet.subnet[subnet.name].id
  }
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}