variable "common_tags" {
  default = {
    Project     = "roboshop"
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "tags" {
  default = {
    Component = "user"
  }
}

variable "project_name" {
  default = "roboshop2"
}

variable "environment" {
  default = "dev"
}

variable "zone_name" {
  default = "forpractice.uno"
}

variable "app_version" {
  
}

variable "iam_instance_profile" {
  default = "iamroleforec2creation"
}