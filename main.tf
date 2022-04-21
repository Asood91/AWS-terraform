module "network" {
  source       = "./modules/network/"
  project      = var.project
  cx_public_ip = var.cx_public_ip ##only for Hub
  onprem_cidr  = var.onprem_cidr  ##only for Hub
  whitelist_IP = var.whitelist_IP ##only for Hub
  for_each     = var.net

  vpc_cidr            = each.value.vpc_cidr
  vpc_name            = each.value.vpc_name
  public_cidr         = each.value.public_cidr
  private_cidr        = each.value.private_cidr
  public_subnet_name  = each.value.public_subnet_name
  private_subnet_name = each.value.private_subnet_name
  public_RT_name      = each.value.public_RT_name


}

# module "ec2-instances" {
#   source   = "./modules/aws-compute"
#   project  = var.project
#   for_each = var.net

#   ami          = each.value.ami
#   instanceType = each.value.instanceType
#   key_name     = each.value.key_name
#   public_cidr  = each.value.public_cidr
#   vpc_name     = each.value.vpc_name
#   sg           = module.SG["${each.key}"].SGID
# }

# module "SG" {
#   source   = "./modules/aws-security-group"
#   project  = var.project
#   for_each = var.net

#   vpc_id   = module.network["${each.key}"].vpcID
#   vpc_name = each.value.vpc_name

# }

module "vpc_peering" {
  source   = "./modules/aws-vpc-peering"
  project  = var.project
  for_each = var.peering

  origin_vpc_cidr            = each.value.origin_vpc_cidr
  destination_vpc_cidr       = each.value.destination_vpc_cidr
  origin_public_subnet       = each.value.origin_public_subnet
  origin_private_subnet      = each.value.origin_private_subnet
  destination_public_subnet  = each.value.destination_public_subnet
  destination_private_subnet = each.value.destination_private_subnet
}




