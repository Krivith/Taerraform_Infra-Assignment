module "rg" {
  source    = "../../modules/Resource_group"
  rg_config = var.rg_config
}

module "vnet" {
  source      = "../../modules/Vnet"
  vnet_config = var.vnet_config
  depends_on  = [module.rg]
}

module "subnet" {
  source        = "../../modules/Subnet"
  subnet_config = var.subnet_config
  depends_on    = [module.vnet]
}

module "pip" {
  source     = "../../modules/PIP"
  ip_config  = var.ip_config
  depends_on = [module.rg]
}

module "nic" {
  source     = "../../modules/Nic"
  nic_config = var.nic_config
  depends_on = [module.subnet, module.pip]
}

module "nsg" {
  source     = "../../modules/NSG"
  nsg_config = var.nsg_config
  depends_on = [module.rg]
}

module "nsg_association" {
  source         = "../../modules/NGS_association"
  nsg_nic_config = var.nsg_nic_config
  depends_on     = [module.nic, module.nsg]
}

module "vm" {
  source     = "../../modules/VM"
  vm_config  = var.vm_config
  depends_on = [module.nic]
}