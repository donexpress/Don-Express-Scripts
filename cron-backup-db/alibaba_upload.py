# -*- coding: utf-8 -*-

import os
import random
import string
import oss2
from datetime import datetime
from pathlib import Path

date_actual = datetime.now().date()
# First, initialize the AccessKeyId, AccessKeySecret, Endpoint and other information.
# Obtained by environment variables, or by such asâ€œ<your_AccessKeyId>â€Replace with a real AccessKeyId and so on.
#
#access_key_id = os.getenv('OSS_TEST_ACCESS_KEY_ID', 'LTAIGmg7WXMnXaOi')
#access_key_secret = os.getenv('OSS_TEST_ACCESS_KEY_SECRET', '6vFzQR3ZVb0Xf3Rg6uZNZZwUv4y3JV')
#bucket_name = os.getenv('OSS_TEST_BUCKET', 'staging-bucket')
#endpoint = os.getenv('OSS_TEST_ENDPOINT', 'https://oss-us-west-1.aliyuncs.com')

# Create a bucket object, all Object related interfaces can be done through the Bucket object
bucket = oss2.Bucket(oss2.Auth('OSS_TEST_ACCESS_KEY_ID', 'OSS_TEST_ACCESS_KEY_SECRET'), 'OSS_TEST_ENDPOINT', 'OSS_TEST_BUCKET')

# Generate a local file for testing. The file content is of type bytes.
filepath = "/tmp/backups/donex_db_backup_" + str(date_actual)

filename = filepath + '.tar.gz'
#filename = './test.png'

#bucket.put_object_from_file('test-upload.png', "./cron-backup-db/test.png")
bucket.put_object_from_file('donex_db_backup_'+ str(date_actual) +'.tar.gz', filename)

# Remove file name path
os.remove(filename)