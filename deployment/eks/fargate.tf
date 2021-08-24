# resource "aws_eks_fargate_profile" "eks_fargate_profile" {
#   cluster_name           = aws_eks_cluster.eks_cluster.name
#   fargate_profile_name   = "ssor-fargate-profile"
#   pod_execution_role_arn = aws_iam_role.fargate_pod_role.arn
#   subnet_ids             = data.aws_subnet_ids.private.ids

#   selector {
#     namespace = "default"
#   }

#   selector {
#     namespace = "kube-system"
#   }

#   depends_on = [
#     aws_iam_role_policy_attachment.eks_fargate_pod_policy,
#     aws_iam_openid_connect_provider.openid,
#     aws_eks_cluster.eks_cluster
#   ]
# }
