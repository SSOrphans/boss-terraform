# locals {
#   alb_service_account_yaml = <<-YAML
# apiVersion: v1
# kind: ServiceAccount
# metadata:
#     labels:
#         app.kubernetes.io/component: controller
#         app.kubernetes.io/name: aws-load-balancer-controller
#     name: aws-load-balancer-controller
#     namespace: kube-system
#     annotations:
#         eks.amazonaws.com/role-arn: ${module.iam_assumable_role_with_oidc.this_iam_role_arn}
# YAML
# }

# resource "null_resource" "eks_alb" {
#   depends_on = [
#     aws_eks_cluster.eks_cluster,
#     aws_eks_fargate_profile.eks_fargate_profile
#   ]

#   provisioner "local-exec" {
#     interpreter = ["/bin/bash", "-c"]

#     command = <<-EOT
#     aws eks update-kubeconfig --region ${data.aws_region.current.name} --name ${aws_eks_cluster.eks_cluster.name}

#     kubectl patch deployment coredns -n kube-system \
#     --type json -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'

#     echo "${local.alb_service_account_yaml}" > alb-service-account.yaml

#     kubectl apply -f alb-service-account.yaml

#     kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master"

#     helm repo add eks https://aws.github.io/eks-charts

#     helm repo update

#     helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller \
#     --set region=${data.aws_region.current.name} \
#     --set vpcId=${data.aws_vpc.selected.id} \
#     --set clusterName=${aws_eks_cluster.eks_cluster.name} \
#     --set image.tag="v2.2.0" \
#     --set serviceAccount.create=false \
#     --set serviceAccount.name=aws-load-balancer-controller \
#     -n kube-system
#     EOT
#   }
# }