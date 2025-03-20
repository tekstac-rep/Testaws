provider "aws" {
  region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

#VPC Creation
resource "aws_vpc" "vpclab" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}


#Internet Gateway Creation
resource "aws_internet_gateway" "igw" {
  tags = {
    Name = var.igw_name
  }
}

#Internet Gateway Attachment
resource "aws_internet_gateway_attachment" "attach_igw" {
  internet_gateway_id = aws_internet_gateway.igw.id
  vpc_id              = aws_vpc.vpclab.id
}

#public subnet creation
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpclab.id
  cidr_block = var.pub_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = var.pub_name
  }
}

#private subnet creation
resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.vpclab.id
  cidr_block = var.pri_cidr
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = var.pri_name
  }
}

#private subnet creation 2
resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.vpclab.id
  cidr_block = var.pri_cidr2
  availability_zone = data.aws_availability_zones.available.names[2]
  tags = {
    Name = var.pri_name2
  }
}

# Fetch Available AZs
data "aws_availability_zones" "available" {}

#public route table creation
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpclab.id
  tags = {
    Name = var.pub_rt_name
  }
}

#create route for internet access
resource "aws_route" "route_internet" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = var.route_internet
  gateway_id = aws_internet_gateway.igw.id
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

#policy creation
# IAM Policy for Student Lab
resource "aws_iam_policy" "student_lab_policy" {
  name        = var.policy_name
  description = "IAM policy for students to manage EC2 instances in ${var.aws_region}"
  policy      = file("policy.json")  # Reference external JSON policy file
}


# Attach Policy to Group
resource "aws_iam_policy_attachment" "student_lab_policy_attachment" {
  name       = "student_lab_policy_attachment"
  policy_arn = aws_iam_policy.student_lab_policy.arn
  groups     = [var.existing_group_name]
}