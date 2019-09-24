# -*- coding: utf-8 -*-

import os
import random
import string
import oss2
from datetime import datetime

date_actual = datetime.now().date()
# First, initialize the AccessKeyId, AccessKeySecret, Endpoint and other information.
# Obtained by environment variables, or by such asâ€œ<your_AccessKeyId>â€Replace with a real AccessKeyId and so on.
#
access_key_id = os.getenv('OSS_TEST_ACCESS_KEY_ID', 'LTAIGmg7WXMnXaOi')
access_key_secret = os.getenv('OSS_TEST_ACCESS_KEY_SECRET', '6vFzQR3ZVb0Xf3Rg6uZNZZwUv4y3JV')
bucket_name = os.getenv('OSS_TEST_BUCKET', 'dev-trash-helpers')
endpoint = os.getenv('OSS_TEST_ENDPOINT', 'oss-us-west-1')


# Confirm that the above parameters are filled in correctly.
for param in (access_key_id, access_key_secret, bucket_name, endpoint):
    assert '<' not in param, 'Please set the parameters:' + param


# Create a bucket object, all Object related interfaces can be done through the Bucket object
bucket = oss2.Bucket(oss2.Auth(access_key_id, access_key_secret), endpoint, bucket_name)

# Generate a local file for testing. The file content is of type bytes. 
filepath = "/tmp/backups/donex_db_backup_" + str(date_actual)

filename = filepath + '.tar.gz'

# Breakpoint resume: Because the file is small (less than oss2.defaults.multipart_threshold),
# So actually use oss2.Bucket.put_object
oss2.resumable_upload(bucket, filename)

# You can also directly call the slice upload interface.
# First, you can use the help function to set the slice size, and let us expect the slice size to be 128KB.
total_size = os.path.getsize(filename)
part_size = oss2.determine_part_size(total_size, preferred_size=128 * 1024)

# Remove file name path
#os.remove(filename)