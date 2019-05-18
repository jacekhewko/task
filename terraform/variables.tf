variable "ami_id" {
    default = "ami-09def150731bdbcc2"
}

variable "jenkins_master_instance_type" {
    default = "t2.medium"
}

variable "jenkins_slave1_instance_type" {
    default = "t2.medium"
}

variable "jenkins_slave2_instance_type" {
    default = "t2.small"
}

variable "aws_profile" {
    default = ""
}

variable "shared_credentials_file" {
    default = ""
}

variable "key_name" {
    default = "tooploox"
}

variable "jenkins_username" {
    default = ""
}

variable "jenkins_password" {
    default = ""
}

variable "jenkins_credentials_id" {
    default = ""
}

variable "sentry_pass" {
}

variable "sentry_login" {
}

variable "ecs_task_execution_role" {
  description = "Role arn for the ecsTaskExecutionRole"
  default     = "arn:aws:iam::account_id:role/ecsTaskExecutionRole"
}