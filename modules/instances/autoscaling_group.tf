resource "aws_autoscaling_group" "ecs_placement_group" {
  health_check_grace_period = 0
  max_size                  = 2
  min_size                  = 0
  launch_configuration      = aws_launch_configuration.as_config.name
  health_check_type         = "EC2"
  desired_capacity          = 2
  max_instance_lifetime     = 0
  metrics_granularity       = "1Minute"
  protect_from_scale_in     = false
  service_linked_role_arn   = "arn:aws:iam::261110884830:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
  vpc_zone_identifier       = [var.subnet_ids[2],
                             var.subnet_ids[3]]
  force_delete              = false
  force_delete_warm_pool    = false
  wait_for_capacity_timeout = "10m"
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                     = "Description"
    propagate_at_launch     = true
    value                   = "This instance is the part of the Auto Scaling group which was created through ECS Console"
  }
  tag {
    key                     = "Name"
    propagate_at_launch     = true
    value                   = "ECS Instance - EC2ContainerService-test-project"
  }
}

resource "aws_launch_configuration" "as_config" {
  image_id      = "ami-086e001f1a73d208c"
  instance_type = "t2.micro"
  security_groups = [var.main_security_group_id]
  key_name = var.key_pair
  iam_instance_profile = "arn:aws:iam::261110884830:instance-profile/ecsInstanceRole"
  vpc_classic_link_security_groups = []
  associate_public_ip_address = false
  ebs_optimized = false
  root_block_device {
    volume_size = 30
    volume_type = "gp2"
    delete_on_termination = false
    encrypted = false
    iops = 0
    throughput = 0
  }
  lifecycle {
    create_before_destroy = true
  }
}

