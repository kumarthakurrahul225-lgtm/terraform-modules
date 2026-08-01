data "azurerm_subnet" "bastion_subnet" {
  for_each             = var.bastion
  name                 = "AzureBastionSubnet"
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.rg-name
}

data "azurerm_public_ip" "bastion_pip" {
  for_each            = var.bastion
  name                = each.value.pip_name
  resource_group_name = each.value.rg-name
}

resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastion
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rg-name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.bastion_subnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.bastion_pip[each.key].id
  }
}

