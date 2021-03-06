# output "ecs_yaml" {
#   value = <<ECS_YAML
# AWSTemplateFormatVersion: '2010-09-09'
# Transform: AWS::Serverless-2016-10-31
# Description: ECS Base Template

# Parameters:
#   ApplicationEnvironment:
#     Type: String
#   ApplicationName:
#     Type: String
#   ECRRepositoryUri:
#     Type: String
#     Description: Full Uri for consumer docker image to run in container

# Resources:

#   # Role for ECS container
#   ContainerExecutionRole:
#     Type: AWS::IAM::Role
#     Properties:
#       RoleName: !Sub '$${ApplicationName}-$${ApplicationEnvironment}-ContainerExecutionRole'
#       Description: IAM Role for ECS container
#       AssumeRolePolicyDocument:
#         Statement:
#           - Effect: Allow
#             Principal:
#               Service:
#                 - ecs-tasks.amazonaws.com
#             Action:
#               - sts:AssumeRole
#       Tags:
#         - Key: ApplicationName
#           Value: !Ref ApplicationName
#         - Key: ApplicationEnvironment
#           Value: !Ref ApplicationEnvironment

#   # Fargate ECS Service
#   MicroService:
#     Type: AWS::ECS::Service
#     DependsOn: ApiListenerRule
#     Properties:
#       ServiceName: !Join [ '-', [ !Ref ApplicationName, !Ref ApplicationEnvironment ] ]
#       Cluster: '${module.ecs.cluster_name}'
#       TaskDefinition: !Ref TaskDefinition
#       DeploymentConfiguration:
#         MinimumHealthyPercent: 100
#         MaximumPercent: 200
#       DesiredCount: 1
#       LaunchType: FARGATE
#       NetworkConfiguration:
#         AwsvpcConfiguration:
#           AssignPublicIp: DISABLED
#           Subnets:
#             - !Sub '{{resolve:secretsmanager:SSOrphans/$${ApplicationEnvironment}:SecretString:Private-Subnet-A}}'
#           SecurityGroups:
#             - !Sub '{{resolve:secretsmanager:SSOrphans/$${ApplicationEnvironment}:SecretString:Base-SecGroup}}'
#       LoadBalancers:
#         - ContainerName: !Ref ApplicationName
#           ContainerPort: 8080
#           TargetGroupArn: !Ref TargetGroup

#   # Fargate Task Definition
#   TaskDefinition:
#     Type: AWS::ECS::TaskDefinition
#     Properties:
#       Family: !Sub $${ApplicationName}-$${ApplicationEnvironment}
#       RequiresCompatibilities:
#         - FARGATE
#       Memory: '2GB'
#       Cpu: '1 vcpu'
#       NetworkMode: awsvpc
#       ExecutionRoleArn: '${module.ecs.task_execution_role_arn}'
#       TaskRoleArn: !Ref ContainerExecutionRole
#       ContainerDefinitions:
#         - Name: !Ref ApplicationName
#           Image: !Ref ECRRepositoryUri # This gets passed as param from ecs.json generated in buildspec
#           PortMappings:
#             - ContainerPort: 8080
#           # Secrets:
#           #   - Name: DB_USERNAME
#           #     ValueFrom: !Sub '{{resolve:secretsmanager:SSOrphans/$${ApplicationEnvironment}:SecretString:rds-user-secret-arn}}'
#           #   - Name: DB_PASSWORD
#           #     ValueFrom: !Sub '{{resolve:secretsmanager:SSOrphans/$${ApplicationEnvironment}:SecretString:rds-password-secret-arn}}'
#           # Environment:
#           #   - Name: APPLICATION_NAME
#           #     Value: !Sub $${ApplicationName}
#           #   - Name: APPLICATION_ENVIRONMENT
#           #     Value: !Ref ApplicationEnvironment
#           #   - Name: PORT
#           #     Value: '8080'
#           #   - Name: DB_HOST_URL
#           #     Value: !Join
#           #       - ''
#           #       - - !Sub 'jdbc:mysql://{{resolve:secretsmanager:SSOrphans/$${ApplicationEnvironment}:SecretString:host}}'
#           #         - !Sub ':{{resolve:secretsmanager:SSOrphans/$${ApplicationEnvironment}:SecretString:port}}'
#           #         - !Sub '/{{resolve:secretsmanager:SSOrphans/$${ApplicationEnvironment}:SecretString:dbname}}'
#           Essential: true
#           Memory: 2048
#           LogConfiguration:
#             LogDriver: awslogs
#             Options:
#               awslogs-group: !Sub /ecs/SSOrphans/$${ApplicationName}/$${ApplicationEnvironment}
#               awslogs-region: !Ref AWS::Region
#               awslogs-stream-prefix: ecs
#               awslogs-create-group: 'true'

#   # Optional
#   TargetGroup:
#     Type: AWS::ElasticLoadBalancingV2::TargetGroup
#     Properties:
#       HealthCheckIntervalSeconds: 60
#       HealthCheckPath: '/'
#       HealthCheckTimeoutSeconds: 5
#       HealthCheckPort: '8080'
#       UnhealthyThresholdCount: 2
#       HealthyThresholdCount: 2
#       Name: !Sub '$${ApplicationName}-$${ApplicationEnvironment}-tg'
#       Port: 8080
#       Protocol: HTTP
#       TargetGroupAttributes:
#         - Key: deregistration_delay.timeout_seconds
#           Value: '60'
#       TargetType: ip
#       VpcId: !Sub '{{resolve:secretsmanager:SSOrphans/$${ApplicationEnvironment}:SecretString:vpc-id}}'

#   ApiListenerRule:
#     Type: AWS::ElasticLoadBalancingV2::ListenerRule
#     Properties:
#       Conditions:
#         - Field: path-pattern
#           Values:
#             - /api/*
#             - /api*
#       Actions:
#         - Type: forward
#           TargetGroupArn: !Ref TargetGroup
#       ListenerArn: !Sub '{{resolve:secretsmanager:SSOrphans/$${ApplicationEnvironment}:SecretString:listener-arn}}'
#       Priority: 10
# ECS_YAML
# }