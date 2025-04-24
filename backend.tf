# backend.tf

terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-ResourceGroup"
    storage_account_name = "terraformoptstoaccount"
    container_name       = "tfstatefile"
    key                  = "test.terraform.tfstate"
    use_oidc             = true
  }
}