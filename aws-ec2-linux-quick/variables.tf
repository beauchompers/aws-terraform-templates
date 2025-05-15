variable "aws_region" {
  type        = string
  description = "The AWS region to deploy in"
}
variable "aws_profile" {
  type        = string
  description = "The AWS profile"
  default     = "default"
}
variable "aws_ami_id" {
  type        = string
  description = "The ami id for the instance"
  default     = "ami-03afc49e3def9a472"
}
variable "aws_instance_type" {
  type        = string
  description = "The AWS instance type to use"
  default     = "t2.micro"
}
variable "aws_number_of_instances" {
  type        = number
  description = "The number of instances to deploy"
  default     = 1
}
variable "aws_ssh_user" {
  type        = string
  description = "The ssh username"
  default     = "ec2-user"
}
variable "aws_ssh_key_name" {
  type        = string
  description = "Public key for ssh login"
  default     = "ssh_key"
}
variable "aws_ssh_keyfile" {
  type        = string
  description = "File path and name for the ssh public key."
  default     = "id_rsa.pub"
}
variable "aws_security_group_name" {
  type        = string
  description = "The name of the AWS security group to create"
  default     = "ec2_server_security_group"
}
variable "aws_ingress_cidrs" {
  type        = list(string)
  description = "list of cidr blocks to allow on security group for inbound access"
  default     = ["0.0.0.0/0"]
}
variable "aws_egress_cidrs" {
  type        = list(string)
  description = "list of cidr blocks to allow on security group for outbound access"
  default     = ["0.0.0.0/0"]
}
