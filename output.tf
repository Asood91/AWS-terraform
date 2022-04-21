output "vpc-ID" {
  value = [
    for bd in module.network : bd.vpcID
  ]
}

#    value = module.network["*"].vpcID ## for array

# output "SG-ID" {
#   value = [
#     for k in module.SG : k.SGID
#   ]
# }
