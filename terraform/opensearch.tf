

resource "aws_opensearch_domain" "main" {
  domain_name    = "${var.project_name}-${var.environment}"
  engine_version = var.opensearch_version


  cluster_config {
    instance_type  = "t3.small.search"
    instance_count = 1
  }




  ebs_options {
    ebs_enabled = true
    volume_type = "gp3"
    volume_size = 20
  }

  domain_endpoint_options {
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  encrypt_at_rest {
    enabled = true
  }

  node_to_node_encryption {
    enabled = true
  }

  advanced_security_options {
    enabled = true
    internal_user_database_enabled = true

    master_user_options {
      master_user_name = var.opensearch_username
      master_user_password = var.opensearch_password
    }
  }

}

resource "aws_opensearch_domain_policy" "main" {
  domain_name = aws_opensearch_domain.main.domain_name

  access_policies = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          AWS = "*"
        }

        Action = "es:*"

        Resource = "${aws_opensearch_domain.main.arn}/*"
      }
    ]
  })
}