variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "access_key" {
  description = "AWS access key"
  type        = string
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "pub_cidr" {
  description = "CIDR block for public subnet"
  type        = string
}

variable "pub_name" {
  description = "Name of the public subnet"
  type        = string
}

variable "pri_cidr" {
  description = "CIDR block for private subnet"
  type        = string
}


variable "pri_name" {
  description = "Name of the private subnet"
  type        = string
}

variable "pri_cidr2" {
  description = "CIDR block for private subnet"
  type        = string
}

variable "pri_name2" {
  description = "Name of the private subnet"
  type        = string
}

variable "pub_rt_name" {
  description = "Name of the public route table"
  type        = string
}

variable "route_internet"{
  description = "Route to internet"
  type = string
}

variable "policy_name" {
  description = "Name of the policy"
  type        = string
}

variable "existing_group_name" {
  description = "Name of the security group"
  type        = string
}
