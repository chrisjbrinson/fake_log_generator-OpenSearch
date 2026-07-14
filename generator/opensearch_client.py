import os
import time

from opensearchpy import OpenSearch


def get_client():

    client = OpenSearch(
        hosts=[
            {
                "host": os.environ["OPENSEARCH_HOST"],
                "port": int(os.environ.get("OPENSEARCH_PORT", "443"))
            }
        ],
        http_auth=(
            os.environ["OPENSEARCH_USERNAME"],
            os.environ["OPENSEARCH_PASSWORD"]
        ),
        use_ssl=True,
        verify_certs=True,
        ssl_assert_hostname=False,
        ssl_show_warn=False,
        timeout=30,
        retry_on_timeout=True,
        max_retries=3,
    )

    print("Waiting for OpenSearch...")

    while True:
        try:
            if client.ping():
                print("Connected!")
                return client
        except Exception as e:
            print(f"Connection failed: {e}")

        print("OpenSearch not ready. Waiting 5 seconds...")
        time.sleep(5)