import random
import uuid


JOBS = [
    "AWS Inventory Discovery",
    "Azure Inventory Discovery",
    "Host Resources by Shell",
    "DNS Discovery",
    "SNMP Network Discovery"
]

PROBES = [
    "Probe-01",
    "Probe-02",
    "Probe-03",
    "Probe-04",
    "Probe-05"
]

ERRORS = [
    "SSH Authentication Failed",
    "AWS API Rate Limit",
    "DNS Timeout",
    "Credential Missing",
    "SNMP Timeout"
]

RUNNING_JOBS = []

def create_ucmdb_event():

    job_id = str(uuid.uuid4())

    event = {
        "application": "UCMDB",
        "job_id": job_id,
        "event_type": "discovery_job",
        "job": random.choice(JOBS),
        "probe": random.choice(PROBES),
        "status": "STARTED",
        "severity": "INFO"
    }

    RUNNING_JOBS.append(event)

    return event