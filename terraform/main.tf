module "azure_vm" {
  source = "./modules/azure-vm"

  subscription_id = var.subscription_id
  resource_group_name           = var.resource_group_name
  location                      = var.location
  azurerm_vnet_name             = var.azurerm_vnet_name
  azurerm_vnet_space            = var.azurerm_vnet_space
  azurerm_subnet_name           = var.azurerm_subnet_name
  azurerm_vnet_address_prefixes = var.azurerm_vnet_address_prefixes

  azurerm_sg_name = var.azurerm_sg_name

  azurerm_sg_rule = var.azurerm_sg_rule


  azurerm_public_ip_name = var.azurerm_public_ip_name
  azurerm_vm_name = var.azurerm_vm_name
  azurerm_vm_size = var.azurerm_vm_size
  azurerm_vm_nic_name = var.azurerm_vm_nic_name
  admin_username         = var.admin_username
  public_key_path        = var.public_key_path
  vnet_enable_public_ip = var.vnet_enable_public_ip

  source_image_reference = {
    publisher = var.source_image_reference.publisher
    offer = var.source_image_reference.offer
    sku = var.source_image_reference.sku
    version = var.source_image_reference.version
  }
}
