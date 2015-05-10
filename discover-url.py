#!/usr/bin/env python

import humblebundle
import sys
import os

filename = sys.argv[2]
username = sys.argv[3]
password = os.environ['PASSWORD']

client = humblebundle.HumbleApi()
client.login(username, password)

order_list = client.order_list()
for order in order_list:
    for subproduct in order.subproducts or []:
        for download in subproduct.downloads or []:
            for download_struct in download.download_struct or []:
                url = download_struct.url.web
                if url and filename in url:
                    print(url)
                    exit()

