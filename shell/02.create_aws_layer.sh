#!/bin/bash
if [ $# -ne 2 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには2個の引数が必要です。" 1>&2
  echo "$0 [S3 Bucket] [AWS CLI Profile]"
  exit 1
fi
Bucket=$1
Profile=$2
rm -rf ./aws-cli-layer
aws s3 cp s3://${Bucket}/provided.tgz  --profile ${Profile} ./aws-cli-layer/
cd ./aws-cli-layer/ \
    && mkdir ./bin \
    && tar -xzvf ./provided.tgz -C ./bin/ \
    && mv ./bin/bin/* ./bin/ \
    && chmod 755 ./bin/* \
    && rm ./provided.tgz 
cd ../
cp ./bootstrap_skeleton ./aws-cli-layer/bootstrap
cd ./aws-cli-layer && zip -r ./aws-cli-layer.zip .
aws lambda publish-layer-version --layer-name aws-cli-layer --zip-file fileb://aws-cli-layer.zip --profile ${Profile}
