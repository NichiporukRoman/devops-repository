export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION

aws s3 cp s3://liveroman/live.txt /tmp/live.txt --endpoint-url=https://storage.yandexcloud.net/
curl -Is http://google.com --max-time $MAX_CURL_TIME | head -n 1 >> /tmp/live.txt
aws s3 cp /tmp/live.txt s3://liveroman/live.txt --endpoint-url=https://storage.yandexcloud.net/

echo '{
    "statusCode": 200,
    "body": "Hello, world!"
}'