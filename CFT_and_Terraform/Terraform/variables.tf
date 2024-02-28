variable "vpc_name" {
    description = "Enter the name of VPC"
    type = string
    default = "VPC_TF_var"
}
variable "vpc_cidr_block" {
    description = "Enter the Cidr of VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "pub_subnets" {
    description = "Give the Public subnet details"
    type = list(object({
      cidr_block = string
      az = string
    }))
    default = [ {
        cidr_block = "10.0.1.0/24"
        az = "us-east-2a"
    }, 
    {
        cidr_block = "10.0.2.0/24"
        az = "us-east-2b"
    }]
}
variable "pri_subnets" {
    description = "Give the Private subnet details"
    type = list(object({
      cidr_block = string
      az = string
    }))
    default = [ {
        cidr_block = "10.0.3.0/24"
        az = "us-east-2a"
    }, 
    {
        cidr_block = "10.0.4.0/24"
        az = "us-east-2b"
    }]
}

# variable "FE_Instance_var" {
#     description = "Details of the FrontEnd Instance"
#     type = object({
#       ins_type = string
#       key = string
#     })
#     default = {
#       ins_type = "t2.micro"
#       key = "TF_Instance"
#     }
# }