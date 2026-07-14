import os
import time
from datetime import datetime, timezone

from event_generator import create_event
from opensearch_client import get_client

client = get_client()

INDEX_PREFIX = os.environ.get("INDEX_PREFIX", "logs")
LOG_INTERVAL = float(os.environ.get("LOG_INTERVAL", "2"))

while True:
    try:
        event = create_event()

        now = datetime.now(timezone.utc)

        index_name = f"{INDEX_PREFIX}-{now.strftime('%Y.%m.%d-%H')}"

        response = client.index(
            index=index_name,
            body=event
        )

        print(f"Indexed {response['_id']} into {index_name}")

    except Exception as e:
        print(f"Failed to index document: {e}")

    time.sleep(LOG_INTERVAL)