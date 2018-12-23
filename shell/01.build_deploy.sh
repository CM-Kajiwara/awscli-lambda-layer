#!/bin/bash
if [ $# -ne 3 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには3個の引数が必要です。" 1>&2
  echo "$0 [Role] [S3 Bucket] [AWS CLI Profile]"
  exit 1
fi
Role=$1
Bucket=$2
Profile=$3
AccountID=`aws sts get-caller-identity --profile ${Profile} | jq -r '.Account'`
rm function.zip
chmod 755 ./bootstrap
chmod 755 ./function.sh
zip function.zip function.sh bootstrap
aws s3 rm s3://${Bucket}/provided.tgz
aws lambda create-function \
  --function-name layer-creater \
  --zip-file fileb://function.zip \
  --handler function.handler \
  --runtime provided \
  --timeout 900 \
  --memory-size 256 \
  --environment Variables={S3_BUCKET=${Bucket}} \
  --role arn:aws:iam::${AccountID}:role/${Role} \
  --profile ${Profile}
aws lambda invoke \
  --invocation-type Event \
  --function-name layer-creater \
  --region ap-northeast-1 \
  --profile ${Profile} outResult.txt