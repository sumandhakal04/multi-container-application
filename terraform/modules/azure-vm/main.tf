resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.azurerm_vnet_name
  address_space       = var.azurerm_vnet_space
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.azurerm_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.azurerm_vnet_address_prefixes
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.azurerm_sg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  dynamic "security_rule" {
    for_each = var.azurerm_sg_rule
    content {
    name                       = security_rule.value.name
    priority                   = security_rule.value.priority
    direction                  = security_rule.value.direction
    access                     = security_rule.value.access
    protocol                   = security_rule.value.protocol
    source_port_range          = security_rule.value.source_port_range
    destination_port_range     = security_rule.value.destination_port_range
    source_address_prefix      = security_rule.value.source_address_prefix
    destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_network_interface" "nic" {
  name                = var.azurerm_vm_nic_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.vnet_enable_public_ip ? azurerm_public_ip.vm_public_ip[0].id : null
  }
}

resource "azurerm_public_ip" "vm_public_ip" {
  count = var.vnet_enable_public_ip ? 1 : 0
  name                = var.azurerm_public_ip_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.azurerm_vm_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  size                = var.azurerm_vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }
}
