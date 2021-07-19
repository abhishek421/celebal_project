provider "azurerm" {
  version         = "2.0.0"
  subscription_id = var.subscriptionID

  features {}
}

resource "azurerm_virtual_machine" "Celebal_VM" {
  name                  = "celebal_vm"
  location              = var.location
  resource_group_name   = var.resourceGroupName
  network_interface_ids = ["${var.network_interface_id}"]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "celebalComp"
    admin_username = "azureuser"
    admin_password = "Password123!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "staging"
  }
}