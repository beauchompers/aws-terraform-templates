variable "aws_region" {
  type        = string
  description = "The AWS region to deploy in"
}
variable "aws_node_instance_type" {
  type        = list(string)
  description = "The AWS instance type to use"
  default     = ["t3.small"]
}
variable "aws_cluster_name" {
  type        = string
  description = "The name of the cluster"
  default     = "eks_cluster"
}
variable "aws_cluster_version" {
  type        = string
  description = "version of the cluster"
  default     = "1.32"
}
variable "aws_public_access_cidrs" {
  type = list(string)
  description = "list of cidr blocks to allow for inbound cluster access"
  default = ["0.0.0.0/0"]
}