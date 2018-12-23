#!/bin/bash
if [ $# -ne 1 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには1個の引数が必要です。" 1>&2
  echo "$0 [AWS CLI Profile]"
  exit 1
fi
Profile=$1
aws lambda delete-function --function-name layer-creater --profile ${Profile}