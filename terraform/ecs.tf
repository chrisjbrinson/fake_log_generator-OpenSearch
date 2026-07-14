resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-${var.environment}"

  tags = {
    Name        = "${var.project_name}-${var.environment}"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_security_group" "ecs_tasks" {
  name        = "${var.project_name}-${var.environment}-ecs-tasks"
  description = "Security group for ECS tasks"
  vpc_id      = aws_vpc.main.id

  egress {
    description = "Allow all outbound"

    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-ecs-tasks"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_ecs_service" "generator" {
  name            = "${var.project_name}-${var.environment}-generator"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.generator.arn

  desired_count = 1
  launch_type   = "FARGATE"

  enable_execute_command = true

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  network_configuration {
    assign_public_ip = true

    subnets = [
      aws_subnet.public_a.id
    ]

    security_groups = [
      aws_security_group.ecs_tasks.id
    ]
  }

  depends_on = [
    aws_cloudwatch_log_group.generator
  ]

  tags = {
    Name        = "${var.project_name}-${var.environment}-generator"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}