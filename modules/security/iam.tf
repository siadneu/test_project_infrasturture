resource "aws_iam_role" "ecsServiceRole" {
  assume_role_policy = jsonencode({
            "Version": "2008-10-17",
            "Statement": [
                {
                    "Sid": "",
                    "Effect": "Allow",
                    "Principal": {
                        "Service": "ecs.amazonaws.com"
                    },
                    "Action": "sts:AssumeRole"
                }
            ]
        })
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"]
}

resource "aws_iam_role" "ecs_task_execution" {
  description           = "Allows ECS tasks to call AWS services on your behalf."
  assume_role_policy = jsonencode({
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Sid": "",
                    "Effect": "Allow",
                    "Principal": {
                        "Service": "ecs-tasks.amazonaws.com"
                    },
                    "Action": "sts:AssumeRole"
                }
            ]
        } )
  managed_policy_arns = [aws_iam_policy.test_project_s3_bucket_rw.arn,
                         "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
}

resource "aws_iam_role" "jenkins_role" {
  name = "jenkins"
  assume_role_policy = jsonencode( {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Principal": {
                        "Service": "ec2.amazonaws.com"
                    },
                    "Action": "sts:AssumeRole"
                }
            ]
        })
  description = "Allows EC2 instances to call AWS services on your behalf."
  managed_policy_arns = [aws_iam_policy.EcsServiceUpdate.arn,
                         aws_iam_policy.test_project_s3_bucket_rw.arn,
                         "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"]
}

resource "aws_iam_policy" "EcsServiceUpdate" {
  description = "update ecs services"
  policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "VisualEditor0",
              "Effect": "Allow",
              "Action": "ecs:UpdateService",
              "Resource": "arn:aws:ecs:*:261110884830:service/*"
          }
      ]
  })
}

resource "aws_iam_policy" "test_project_s3_bucket_rw" {
  description = "rw access to s3 testprojectbucket"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
           {
              "Sid": "VisualEditor0",
              "Effect": "Allow",
              "Action": [
                  "s3:PutObject",
                  "s3:GetObject",
                  "s3:ListBucket"
              ],
              "Resource": [
                  "arn:aws:s3:::testprojectmessages/*",
                  "arn:aws:s3:::testprojectmessages"
              ]
          }
      ]
  })
  tags = {
    project = "test_project"
  }
}