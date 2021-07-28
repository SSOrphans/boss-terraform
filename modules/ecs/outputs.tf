output "cluster_name" {
  value = aws_ecs_cluster.cluster.name
}

output "task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}
