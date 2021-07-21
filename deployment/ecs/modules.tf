module "ecs" {
  source                       = "../../modules/ecs"
  ecs_cluster_info             = var.ecs_cluster_info
  ecs_task_execution_role_name = var.ecs_task_execution_role_name
}
