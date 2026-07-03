import random
import uuid
from datetime import datetime, timezone


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


def start_job():

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

    RUNNING_JOBS.append(
        {
            "job_id": job_id,
            "job": event["job"],
            "probe": event["probe"],
            "started_at": datetime.now(timezone.utc),
            "step": 0
        }
    )

    return event


def advance_job():

    running_job = RUNNING_JOBS[0]

    running_job["step"] += 1

    return {
        "application": "UCMDB",
        "job_id": running_job["job_id"],
        "event_type": "discovery_job",
        "job": running_job["job"],
        "probe": running_job["probe"],
        "status": "CONNECTING",
        "severity": "INFO"
    }


def finish_job():

    running_job = RUNNING_JOBS.pop(0)

    return {
        "application": "UCMDB",
        "job_id": running_job["job_id"],
        "event_type": "discovery_job",
        "job": running_job["job"],
        "probe": running_job["probe"],
        "status": "SUCCESS",
        "severity": "INFO",
        "duration_ms": int(
            (
                datetime.now(timezone.utc)
                - running_job["started_at"]
            ).total_seconds() * 1000
        )
    }


def create_ucmdb_event():

    if RUNNING_JOBS:

        roll = random.random()

        if roll < 0.4:
            return advance_job()

        if roll < 0.8:
            return finish_job()

    return start_job()