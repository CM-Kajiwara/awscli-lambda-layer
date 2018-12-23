#!/bin/bash
if [ $# -ne 2 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには2個の引数が必要です。" 1>&2
  echo "$0 [LambdaFunctionName] [AWS CLI Profile]"
  exit 1
fi
FunctionName=$1
Profile=$2
Layer=`aws lambda list-layers --profile ${Profile}  | jq -r '.[][]| select(.LayerName =="aws-cli-layer") | .LatestMatchingVersion.LayerVersionArn'`
aws lambda update-function-configuration \
    --function-name ${FunctionName} \
    --layers ${Layer} \
    --profile ${Profile}