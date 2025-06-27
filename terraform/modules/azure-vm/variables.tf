variable "subscription_id" {
  description = "Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "azurerm_vnet_name" {
  description = "Name of Vnet"
  type        = string
}

variable "azurerm_vnet_space" {
  description = "vnet address space"
  type        = list(string)
}

variable "azurerm_subnet_name" {
  description = "Name of subnet"
  type        = string
}

variable "azurerm_vnet_address_prefixes" {
  description = "Address prefixes for vnet"
  type        = list(string)
}

variable "azurerm_sg_name" {
  description = "Name of the security group"
  type        = string
}

variable "azurerm_sg_rule" {
  description = "Map of values for the SSH security rule"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "azurerm_public_ip_name" {
  description = "Name of the public IP"
  type        = string
  
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "public_key_path" {
  description = "Path to your public SSH key"
  type        = string
}


variable "azurerm_vm_name" {
  description = "Name of the VM to be created"
  type        = string
}

variable "azurerm_vm_size" {
  description = "Instance size of the VM"
  type        = string
}

variable "azurerm_vm_nic_name" {
  description = "Name of the VM's NIC"
  type        = string
}

variable "vnet_enable_public_ip" {
  description = "Flag for public IP on the vnet"
  type = bool
}

variable "source_image_reference" {
  description = "Information on source Image"
  type = object({
    publisher = string
    offer = string
    sku = string
    version = string
  })
  
}