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