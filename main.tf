resource "azurerm_resource_group" "VM1" {
    for_each = var.VM
    name = each.value.Name
  location = each.value.loc
}

resource "azurerm_virtual_network" "VN1" {
    for_each = var.VM
    resource_group_name = azurerm_resource_group.VM1[each.key].name
    address_space = each.value.add
    location = each.value.loc
name = each.value.vname
  
}

resource "azurerm_subnet" "S1" {
    for_each = var.VM
    name = each.value.sname
    resource_group_name = azurerm_resource_group.VM1[each.key].name
    address_prefixes = each.value.sadd
    virtual_network_name = azurerm_virtual_network.VN1[each.key].name
  
}

resource "azurerm_network_interface" "NIC1" {
    for_each = var.VM
    name = each.value.nicname
    location = each.value.loc
    resource_group_name = azurerm_resource_group.VM1[each.key].name
  
  ip_configuration {
    name = "testip"
    subnet_id = azurerm_subnet.S1[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {

    for_each = var.VM
  name                  = "VM_Dev_kamal"
  location              = each.value.loc
  resource_group_name   = azurerm_resource_group.VM1[each.key].name
  network_interface_ids = [azurerm_network_interface.NIC1[each.key].id]
  vm_size               = "Standard_D2s_v3"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "Kamal-ubuntu"
    admin_username = "Azureuserkamal"
    admin_password = "Development@2026"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}