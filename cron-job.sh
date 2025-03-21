#!/bin/bash

# Create a cron job to upload HTTPD log files to S3 bucket
(crontab -l 2>/dev/null; echo "0 * * * * aws s3 cp /var/log/httpd/ s3://YOUR_S3_BUCKET_NAME/httpd-logs/ --recursive") | crontab -