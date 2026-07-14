resource "aws_secretsmanager_secret" "opensearch" {
  name = "${var.project_name}-${var.environment}-opensearch"

  tags = {
    Name        = "${var.project_name}-${var.environment}-opensearch"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_secretsmanager_secret_version" "opensearch" {
  secret_id = aws_secretsmanager_secret.opensearch.id

  secret_string = jsonencode({
    username = var.opensearch_username
    password = var.opensearch_password
  })
}