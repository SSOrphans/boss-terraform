module "ecs" {
  source = "../../modules/ecs"

  ecs_task_execution_role_name = "ecs-task-execute-role"

  ecs_cluster_info = {
    cluster_name  = "ssor-ecs-cluster"
    setting_value = "disabled"
  }

  vpc_data_inputs = {
    vpc_tag           = "ssor-vpc"
    alb_name          = "ssor-alb"
    alb_listener_port = 80
    subnet_tag        = "ssor-sub-private1"
    sg_tag            = "ssor-sg"
  }

  sm_info = {
    name            = "SSOrphans/dev"
    recovery_window = 0
  }
}
