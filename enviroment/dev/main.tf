module "resource_group_name" {
  source = "../../module/azurerm_resource_group"
  rgs    = var.rgs

}
module "vnet" {
  depends_on = [module.resource_group_name]
  source     = "../../module/azurerm_vnet"
  vnet       = var.vnet
}
module "subnet" {
  depends_on = [module.vnet]
  source     = "../../module/azurerm_subnet"
  dev_subnet = var.dev_subnet
}
module "public_ip" {
  depends_on = [module.resource_group_name]
  source     = "../../module/azurerm_pip"
  pip        = var.pip

}
module "vartul_machine" {
  depends_on = [module.vnet, module.subnet]

  source = "../../module/azurerm_vm"
  vms    = var.vms
}
module "bastion" {
  depends_on = [module.resource_group_name, module.public_ip, module.subnet]
  source     = "../../module/azurerm_bastion"
  bastion    = var.bastion
}