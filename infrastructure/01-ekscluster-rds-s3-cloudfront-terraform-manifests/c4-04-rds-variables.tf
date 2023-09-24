variable "env" {
    default = "env" 
}

# variable "vpc_id" {
#      default = module.vpc.vpc_id
# }

# variable "vpc_private_subnet_ids" {
#     default = module.vpc.private_subnets
# }

# variable "vpc_cidr" {
#     default = module.vpc.vpc_cidr_block
# }

#  variable "azs" {
#      default = 1
#  }

variable "db_identifier" {
  default = "exam-perntodo-ethan"
}

variable "db_name" {
  default = "perntodo"
}

variable "db_user" {
  default = "postgres"
}

variable "db_engine" {
  default = "postgres"
}

variable "db_engine_version" {
  default = "13.7"
}