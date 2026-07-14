resource "aws_security_group" "opensearch" {
  name        = "${var.project_name}-${var.environment}-opensearch"
  description = "Security group for OpenSearch"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTPS"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      var.my_ip
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-opensearch-sg"
  }
}

resource "aws_opensearch_domain" "main" {
  domain_name    = "${var.project_name}-${var.environment}"
  engine_version = var.opensearch_version

  cluster_config {
    instance_type  = "t3.small.search"
    instance_count = 1
  }
}