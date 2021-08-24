resource "aws_eks_cluster" "eks_cluster" {
  name     = "ssor-eks-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    security_group_ids = [data.aws_security_group.selected.id]
    subnet_ids         = data.aws_subnet_ids.all.ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_res_control,
  ]
}