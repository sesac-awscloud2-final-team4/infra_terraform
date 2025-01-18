terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "aws_profile" {
  type			= string
  description	= "your aws configure profile name"
  default       = "sesac"
}

variable "project_name" {
  type			= string
  description	= "project name"
  default       = "sesac-final"
}

variable "aws_region" {
  type			= string
  description	= "vpc region name"
  default       = "ap-southeast-1"
}

variable "key_pair_path" {
  type			= string
  description	= "terraform key pair file path"
  default       = "~/.ssh/"
}

variable "key_pair_name" {
  type			= string
  description	= "terraform key pair file name"
  default       = "sesac_tf.key.pub"
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_key_pair" "project-key" {
  key_name   = "project-key"
  public_key = file("${var.key_pair_path}${var.key_pair_name}")

  tags = {
    Name = "project-key"
  }
}
