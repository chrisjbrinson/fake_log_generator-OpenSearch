from opensearchpy import OpenSearch
import time


def get_client():

    client = OpenSearch(
        hosts=[{"host": "opensearch", "port": 9200}],
        http_auth=("admin", "MyStrongPassword123!"),
        use_ssl=True,
        verify_certs=False,
        ssl_assert_hostname=False,
        ssl_show_warn=False,
    )

    print("Waiting for OpenSearch...")

    while True:
        try:
            if client.ping():
                print("Connected!")
                return client
        except Exception:
            pass

        print("OpenSearch not ready. Waiting 5 seconds...")
        time.sleep(5)