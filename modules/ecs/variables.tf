variable "ecs_cluster_info" {
  type = object({
    cluster_name  = string
    setting_value = string
  })
  description = "Provide a cluster and tag name; setting_value is to enabled/disabled containerInsights"
}

variable "ecs_task_execution_role_name" {
  type        = string
  description = "Name for execution role (ECS CloudFormation template)"
}

variable "vpc_data_inputs" {
  type = object({
    vpc_tag           = string
    alb_name          = string
    alb_listener_port = number
    subnet_tag        = string
    sg_tag            = string
  })
  description = "Tag names and listener port to filter data resource blocks"
}

variable "sm_info" {
  type = object({
    name            = string
    recovery_window = number
  })
  description = "Provide secret manager's name and recovery window number in days"
}
