#!/bin/bash
if [ $# -ne 2 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには2個の引数が必要です。" 1>&2
  echo "$0 [LambdaFunctionName] [AWS CLI Profile]"
  exit 1
fi
FunctionName=$1
Profile=$2
rm function.zip
zip function.zip -j ./include-aws-cli/function.sh
aws lambda update-function-code \
    --function-name ${FunctionName} \
    --zip-file fileb://function.zip \
    --profile ${Profile}
