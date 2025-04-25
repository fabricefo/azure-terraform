terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-ResourceGroup"
    storage_account_name = "terraformoptstoaccount"
    container_name       = "tfstate"
    key                  = "test.ffo.tfstate"
    use_oidc             = true

  }
}