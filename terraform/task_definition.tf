resource "aws_ecs_task_definition" "generator" {
  family                   = "${var.project_name}-${var.environment}-generator"
  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"

  cpu    = 256
  memory = 512

  execution_role_arn = aws_iam_role.ecs_task_execution.arn
  task_role_arn      = aws_iam_role.ecs_task.arn

  container_definitions = jsonencode([
    {
      name  = "generator"

      image = "${aws_ecr_repository.generator.repository_url}:latest"

      essential = true

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.generator.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }

      environment = [
        {
          name  = "OPENSEARCH_HOST"
          value = aws_opensearch_domain.main.endpoint
        },
        {
          name  = "INDEX_PREFIX"
          value = "logs"
        },
        {
          name  = "LOG_INTERVAL"
          value = "2"
        }
      ]

      secrets = [
        {
          name      = "OPENSEARCH_USERNAME"
          valueFrom = "${aws_secretsmanager_secret.opensearch.arn}:username::"
        },
        {
          name      = "OPENSEARCH_PASSWORD"
          valueFrom = "${aws_secretsmanager_secret.opensearch.arn}:password::"
        }
      ]
    }
  ])
}