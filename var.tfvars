project = "tf_aws"

#### START - WAF variables for hub ####
cx_public_ip = "0.0.0.0"
onprem_cidr  = "0.0.0.0/24"
whitelist_IP = "0.0.0.0/24"
#### END - WAF variables for hub ####

net = {
  hub = {
    vpc_cidr            = "10.1.0.0/16"
    vpc_name            = "vpc_hub"
    public_cidr         = "10.1.1.0/24"
    private_cidr        = "10.1.2.0/24"
    public_subnet_name  = "subnet_public_hub"
    private_subnet_name = "subnet_private_hub"
    public_RT_name      = "RT_public_hub"
    ami                 = "ami-0c02fb55956c7d316"
    instanceType        = "t2.micro"
    key_name            = "Key-console"
  },
  spoke_A = {
    vpc_cidr            = "10.2.0.0/16"
    vpc_name            = "vpc_spoke_A"
    public_cidr         = "10.2.1.0/24"
    private_cidr        = "10.2.2.0/24"
    public_subnet_name  = "subnet_public_spoke_A"
    private_subnet_name = "subnet_private_spoke_A"
    public_RT_name      = "RT_public_spoke_A"
    ami                 = "ami-0c02fb55956c7d316"
    instanceType        = "t2.micro"
    key_name            = "Key-console"

  },
  spoke_B = {
    vpc_cidr            = "10.3.0.0/16"
    vpc_name            = "vpc_spoke_B"
    public_cidr         = "10.3.1.0/24"
    private_cidr        = "10.3.2.0/24"
    public_subnet_name  = "subnet_public_spoke_B"
    private_subnet_name = "subnet_private_spoke_B"
    public_RT_name      = "RT_public_spoke_B"
    ami                 = "ami-0c02fb55956c7d316"
    instanceType        = "t2.micro"
    key_name            = "Key-console"

  }
}

peering = {
  hub_spokeA = {
    origin_vpc_cidr            = "10.1.0.0/16"
    destination_vpc_cidr       = "10.2.0.0/16"
    origin_public_subnet       = "10.1.1.0/24"
    origin_private_subnet      = "10.1.2.0/24"
    destination_public_subnet  = "10.2.1.0/24"
    destination_private_subnet = "10.2.2.0/24"
  }
}