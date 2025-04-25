env      = "PROD"
location = "francecentral"

# network
address_space        = ["10.101.0.0/16"]
address_snet_public  = ["10.101.1.0/24"]
address_snet_private = ["10.101.2.0/24"]

# tags
tags = {
  app_owner         = "INFRA"
  app_code          = "FFO"
  technical_contact = "ffourel@gmail.com"
  date_creation     = "24/04/2025"
}