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
            info = client.info()
            print(f"Connected! OpenSearch {info['version']['number']}")
            return client

        except Exception as e:
            print(f"Connection failed: {repr(e)}")
            print(f"Username: {os.environ.get('OPENSEARCH_USERNAME')}")

        print("OpenSearch not ready. Waiting 5 seconds...")
        time.sleep(5)