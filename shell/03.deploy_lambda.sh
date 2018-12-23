#!/bin/bash
if [ $# -ne 3 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには3個の引数が必要です。" 1>&2
  echo "$0 [LambdaFunctionName] [Role] [AWS CLI Profile]"
  exit 1
fi
FunctionName=$1
RoleName=$2
Profile=$3
AccountID=`aws sts get-caller-identity --profile ${Profile} | jq -r '.Account'`
Layer=`aws lambda list-layers --profile ${Profile}  | jq -r '.[][]| select(.LayerName =="aws-cli-layer") | .LatestMatchingVersion.LayerVersionArn'`
rm function.zip
zip function.zip -j ./include-aws-cli/function.sh
aws lambda create-function \
    --function-name ${FunctionName} \
    --zip-file fileb://function.zip \
    --handler function.handler \
    --runtime provided \
    --role arn:aws:iam::${AccountID}:role/${RoleName} \
    --layers  ${Layer} \
    --timeout 30 \
    --profile ${Profile}
