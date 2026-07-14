variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "my_ip" {
  description = "Public IP address allowed to access OpenSearch"
  type        = string
}

variable "opensearch_version" {
  description = "OpenSearch engine version"
  type        = string
}