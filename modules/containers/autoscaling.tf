resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 4
  min_capacity       = 2
  resource_id        = "service/test-project/backend"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ScaleOutPolicy" {
  name               = "ScaleOutPolicy"
  service_namespace = "ecs"
  resource_id        = "service/test-project/backend"
  scalable_dimension = "ecs:service:DesiredCount"
  policy_type = "StepScaling"
  step_scaling_policy_configuration {
    adjustment_type = "ChangeInCapacity"
    step_adjustment {
      scaling_adjustment = 1
      metric_interval_lower_bound = "0"
    }
    cooldown = 300
    metric_aggregation_type = "Average"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "cpu1"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  dimensions = {
    ClusterName = "test-project"
    ServiceName = "backend"
  }
  metric_name = "CPUUtilization"
  namespace = "AWS/ECS"
  period = 300
  statistic = "Average"
  threshold = 90
  unit = "Percent"
  alarm_actions = [aws_appautoscaling_policy.ScaleOutPolicy.arn]
}

resource "aws_appautoscaling_policy" "ScaleInPolicy" {
  name               = "ScaleInPolicy"
  resource_id        = "service/test-project/backend"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  step_scaling_policy_configuration {
    metric_aggregation_type = "Average"
    adjustment_type = "ExactCapacity"
    cooldown = 300
    step_adjustment {
      scaling_adjustment = 2
      metric_interval_upper_bound = "0"
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu" {
  alarm_name          = "cpu"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  dimensions = {
    ClusterName = "test-project"
    ServiceName = "backend"
  }
  alarm_actions = [aws_appautoscaling_policy.ScaleInPolicy.arn]
  metric_name = "CPUUtilization"
  namespace = "AWS/ECS"
  period = 300
  statistic = "Average"
  threshold = 20
  unit = "Percent"
}