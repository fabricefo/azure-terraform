
################
# Resource Group
variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "test-ResourceGroup"
}

################
# Location
variable "location" {
  description = "Azure region"
  default = "francecentral"
}

################
# Network
variable "address_space" {
  type    = list(string)
  default = [""]
}
variable "address_snet_public" {
  type    = list(string)
  default = [""]
}
variable "address_snet_private" {
  type    = list(string)
  default = [""]
}

################
# Tags
variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."

  default = {
    source = "terraform"
  }
}