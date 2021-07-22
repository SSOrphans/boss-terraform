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