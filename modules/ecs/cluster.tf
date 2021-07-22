resource "aws_ecs_cluster" "cluster" {
  name = var.ecs_cluster_info.cluster_name
  tags = {
    Name = var.ecs_cluster_info.cluster_name
  }

  setting {
    name  = "containerInsights"
    value = var.ecs_cluster_info.setting_value
  }

  depends_on = [
    aws_secretsmanager_secret_version.sm_sv_encode
  ]
}
