## EKS Cluster
resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}

resource "aws_iam_role_policy_attachment" "eks_res_control" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_role.name
}

# resource "aws_iam_openid_connect_provider" "openid" {
#   url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer

#   client_id_list = [
#     "sts.amazonaws.com",
#   ]

#   thumbprint_list = []

#   depends_on = [
#     aws_eks_cluster.eks_cluster
#   ]
# }

# ## Fargate Profile
# resource "aws_iam_role" "fargate_pod_role" {
#   name = "eks-fargate-pod-role"

#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "eks-fargate-pods.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# POLICY
# }

# resource "aws_iam_role_policy_attachment" "eks_fargate_pod_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
#   role       = aws_iam_role.fargate_pod_role.name
# }

# ## AWS Load Balancer Controller
# resource "aws_iam_policy" "eks_alb_policy" {
#   name = "eks-alb-policy"

#   policy = <<POLICY
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "iam:CreateServiceLinkedRole",
#                 "ec2:DescribeAccountAttributes",
#                 "ec2:DescribeAddresses",
#                 "ec2:DescribeAvailabilityZones",
#                 "ec2:DescribeInternetGateways",
#                 "ec2:DescribeVpcs",
#                 "ec2:DescribeSubnets",
#                 "ec2:DescribeSecurityGroups",
#                 "ec2:DescribeInstances",
#                 "ec2:DescribeNetworkInterfaces",
#                 "ec2:DescribeTags",
#                 "ec2:GetCoipPoolUsage",
#                 "ec2:DescribeCoipPools",
#                 "elasticloadbalancing:DescribeLoadBalancers",
#                 "elasticloadbalancing:DescribeLoadBalancerAttributes",
#                 "elasticloadbalancing:DescribeListeners",
#                 "elasticloadbalancing:DescribeListenerCertificates",
#                 "elasticloadbalancing:DescribeSSLPolicies",
#                 "elasticloadbalancing:DescribeRules",
#                 "elasticloadbalancing:DescribeTargetGroups",
#                 "elasticloadbalancing:DescribeTargetGroupAttributes",
#                 "elasticloadbalancing:DescribeTargetHealth",
#                 "elasticloadbalancing:DescribeTags"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "cognito-idp:DescribeUserPoolClient",
#                 "acm:ListCertificates",
#                 "acm:DescribeCertificate",
#                 "iam:ListServerCertificates",
#                 "iam:GetServerCertificate",
#                 "waf-regional:GetWebACL",
#                 "waf-regional:GetWebACLForResource",
#                 "waf-regional:AssociateWebACL",
#                 "waf-regional:DisassociateWebACL",
#                 "wafv2:GetWebACL",
#                 "wafv2:GetWebACLForResource",
#                 "wafv2:AssociateWebACL",
#                 "wafv2:DisassociateWebACL",
#                 "shield:GetSubscriptionState",
#                 "shield:DescribeProtection",
#                 "shield:CreateProtection",
#                 "shield:DeleteProtection"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ec2:AuthorizeSecurityGroupIngress",
#                 "ec2:RevokeSecurityGroupIngress"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ec2:CreateSecurityGroup"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ec2:CreateTags"
#             ],
#             "Resource": "arn:aws:ec2:*:*:security-group/*",
#             "Condition": {
#                 "StringEquals": {
#                     "ec2:CreateAction": "CreateSecurityGroup"
#                 },
#                 "Null": {
#                     "aws:RequestTag/elbv2.k8s.aws/cluster": "false"
#                 }
#             }
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ec2:CreateTags",
#                 "ec2:DeleteTags"
#             ],
#             "Resource": "arn:aws:ec2:*:*:security-group/*",
#             "Condition": {
#                 "Null": {
#                     "aws:RequestTag/elbv2.k8s.aws/cluster": "true",
#                     "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
#                 }
#             }
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ec2:AuthorizeSecurityGroupIngress",
#                 "ec2:RevokeSecurityGroupIngress",
#                 "ec2:DeleteSecurityGroup"
#             ],
#             "Resource": "*",
#             "Condition": {
#                 "Null": {
#                     "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
#                 }
#             }
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "elasticloadbalancing:CreateLoadBalancer",
#                 "elasticloadbalancing:CreateTargetGroup"
#             ],
#             "Resource": "*",
#             "Condition": {
#                 "Null": {
#                     "aws:RequestTag/elbv2.k8s.aws/cluster": "false"
#                 }
#             }
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "elasticloadbalancing:CreateListener",
#                 "elasticloadbalancing:DeleteListener",
#                 "elasticloadbalancing:CreateRule",
#                 "elasticloadbalancing:DeleteRule"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "elasticloadbalancing:AddTags",
#                 "elasticloadbalancing:RemoveTags"
#             ],
#             "Resource": [
#                 "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
#                 "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
#                 "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
#             ],
#             "Condition": {
#                 "Null": {
#                     "aws:RequestTag/elbv2.k8s.aws/cluster": "true",
#                     "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
#                 }
#             }
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "elasticloadbalancing:AddTags",
#                 "elasticloadbalancing:RemoveTags"
#             ],
#             "Resource": [
#                 "arn:aws:elasticloadbalancing:*:*:listener/net/*/*/*",
#                 "arn:aws:elasticloadbalancing:*:*:listener/app/*/*/*",
#                 "arn:aws:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
#                 "arn:aws:elasticloadbalancing:*:*:listener-rule/app/*/*/*"
#             ]
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "elasticloadbalancing:ModifyLoadBalancerAttributes",
#                 "elasticloadbalancing:SetIpAddressType",
#                 "elasticloadbalancing:SetSecurityGroups",
#                 "elasticloadbalancing:SetSubnets",
#                 "elasticloadbalancing:DeleteLoadBalancer",
#                 "elasticloadbalancing:ModifyTargetGroup",
#                 "elasticloadbalancing:ModifyTargetGroupAttributes",
#                 "elasticloadbalancing:DeleteTargetGroup"
#             ],
#             "Resource": "*",
#             "Condition": {
#                 "Null": {
#                     "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
#                 }
#             }
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "elasticloadbalancing:RegisterTargets",
#                 "elasticloadbalancing:DeregisterTargets"
#             ],
#             "Resource": "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "elasticloadbalancing:SetWebAcl",
#                 "elasticloadbalancing:ModifyListener",
#                 "elasticloadbalancing:AddListenerCertificates",
#                 "elasticloadbalancing:RemoveListenerCertificates",
#                 "elasticloadbalancing:ModifyRule"
#             ],
#             "Resource": "*"
#         }
#     ]
# }
# POLICY
# }

# module "iam_assumable_role_with_oidc" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
#   version = "~> 3.0"

#   create_role = true

#   role_name = "eks-alb-role"

#   provider_url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer

#   oidc_fully_qualified_subjects = [
#       "system:serviceaccount:kube-system:aws-load-balancer-controller"
#   ]

#   role_policy_arns = [
#     aws_iam_policy.eks_alb_policy.arn,
#   ]

#   number_of_role_policy_arns = 1

#   depends_on = [
#     aws_iam_policy.eks_alb_policy,
#     aws_eks_cluster.eks_cluster
#   ]
# }