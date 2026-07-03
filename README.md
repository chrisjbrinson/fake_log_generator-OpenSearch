# OpenSearch Enterprise Log Simulator

A Python-based log simulator that generates realistic enterprise events and ingests them into OpenSearch for learning and experimentation.
Make sure to change the OpenSearch admin password

## Features

- Python log generator
- OpenSearch & OpenSearch Dashboards via Docker Compose
- Simulated enterprise applications
  - UCMDB
  - Axonius
  - AWS Discovery
  - Terraform
- Hourly time-based indices
- Index State Management (3-hour retention)
- Interactive dashboards and visualizations


## Getting Started

Start the environment:

```bash
docker compose up --build
```

Open OpenSearch Dashboards:

```
http://localhost:5601
```

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