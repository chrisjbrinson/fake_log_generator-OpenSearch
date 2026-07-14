# OpenSearch Enterprise Log Simulator

A Python-based log simulator that generates realistic enterprise events and ingests them into OpenSearch for learning and experimentation.

For simplicity, the OpenSearch domain is publicly accessible in this lab. In production, I would deploy it into private subnets to restrict access.

## Features

- Python log generator running as an ECS Task
- OpenSearch & OpenSearch Dashboards 
- Simulated enterprise applications
  - UCMDB
  - Axonius
  - AWS Discovery
  - Terraform
- Hourly time-based indices
- Index State Management (3-hour retention)
- Interactive dashboards and visualizations



## Goals

This project is a hands-on lab for learning:

- OpenSearch
- Query DSL
- Dashboards & Visualizations
- Index Management
- Index State Management (ISM)
- Python automation
- Enterprise observability

## Roadmap

- Additional enterprise simulators
- Alerting
- Index templates
- AI-powered incident summaries
- Machine learning & anomaly detection