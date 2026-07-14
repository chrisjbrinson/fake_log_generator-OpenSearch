output "repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.generator.repository_url
}

output "opensearch_endpoint" {
  description = "OpenSearch endpoint"

  value = aws_opensearch_domain.main.endpoint
}