env      = "TEST"
location = "francecentral"

# network
address_space        = ["10.100.0.0/16"]
address_snet_public  = ["10.100.1.0/24"]
address_snet_private = ["10.100.2.0/24"]

# tags
tags = {
  app_owner         = "INFRA"
  app_code          = "FFO"
  technical_contact = "ffourel@gmail.com"
  date_creation     = "24/04/2025"
}

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