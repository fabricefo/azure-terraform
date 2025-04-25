################################
# Variables for naming convention

#---------
# Compagny trigram
variable "company_trig" {
  default = "OPT"
}
#---------
# Environment
variable "env" {
  default = "TEST"
}

#---------
# Short Service/Project name 
variable "service_name" {
  type    = string
  default = "FFO"
}

################################
# Location
variable "location" {
  description = "Azure region"
  default     = "francecentral"
}

################################
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

################################
# Tags
variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."

  default = {
    source = "terraform"
  }
}

################################
# Custom data
locals {
  custom_data = <<-EOF
    #cloud-config
    package_update: true
    package_upgrade: true
    packages:
      - nginx
    runcmd:
      - systemctl enable nginx
      - systemctl start nginx
  EOF
}