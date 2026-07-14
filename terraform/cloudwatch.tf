resource "aws_cloudwatch_log_group" "generator" {
  name              = "/ecs/${var.project_name}-${var.environment}-generator"
  retention_in_days = 14

  tags = {
    Name        = "${var.project_name}-${var.environment}-generator"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}