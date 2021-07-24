resource "aws_secretsmanager_secret" "sm" {
  name                    = var.sm_info.name
  recovery_window_in_days = var.sm_info.recovery_window
}

resource "aws_secretsmanager_secret_version" "sm_sv_encode" {
  secret_id     = aws_secretsmanager_secret.sm.id
  secret_string = <<SECRET
{
  "ecs-cluster-name" : "${var.ecs_cluster_info.cluster_name}",
  "ecs-task-execution-role" : "${aws_iam_role.ecs_task_execution_role.arn}",
  "vpc_id" : "${data.aws_vpc.this.id}",
  "listener-arn" : "${data.aws_alb_listener.this.arn}",
  "Private-Subnet-A" : "${data.aws_subnet.this.id}",
  "Base-SecGroup" : "${data.aws_security_group.this.id}",
  ${fileexists("./secret") ? file("./secret") : "\"secret\" : \"\""}
}
SECRET

  depends_on = [
    data.aws_vpc.this
  ]
}
