from datetime import datetime, timezone

from opensearch_client import get_client
from event_generator import create_event
import time

client = get_client()

while True:

    event = create_event()

    now = datetime.now(timezone.utc)

    index_name = now.strftime("logs-%Y.%m.%d-%H")

    response = client.index(
        index=index_name,
        body=event,
        refresh=True
    )

    print(f"Indexed {response['_id']} into {index_name}")

    time.sleep(2)