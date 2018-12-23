# AWS CLI Layer For AWS Lambda

Use AWS CLI in AWS Lambda.

## Usage

### Requirements

* jq
* aws cli
* zip
* tar

### Deployment

1. Prepared this aws resource
    * S3 Bucket (Upload AWS CLI)
    * IAM Role(S3 upload)
1. Create AWS CLI Component
    ```bash
    ./shell/01.build_deploy.sh [Role] [S3 Bucket] [AWS CLI Profile]
    ```
1. Create AWS CLI Layer
    ```bash
    ./shell/02.create_aws_layer.sh [S3 Bucket] [AWS CLI Profile]
    ```
1. Deploy use AWS CLI Layer Lambda
    ```bash
    ./shell/03.deploy_lambda.sh [LambdaFunctionName] [Role] [AWS CLI Profile]
    ```
1. Delete Unnecessary AWS Lambda
    ```
    ./shell/04.delete_layer_creater.sh [AWS CLI Profile]
    ```
1. Update lambda layer version(Optional)
    ```
    ./shell/05.update_lambda_layer_version.sh [LambdaFunctionName] [AWS CLI Profile]
    ```
1. Update lambda layer code(Optional)
    ```
    ./shell/06.update_lambda.sh [LambdaFunctionName] [AWS CLI Profile]
    ```