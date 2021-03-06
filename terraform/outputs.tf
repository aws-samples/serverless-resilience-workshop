# MIT No Attribution
#
# Copyright 2021 Amazon Web Services
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this
# software and associated documentation files (the "Software"), to deal in the Software
# without restriction, including without limitation the rights to use, copy, modify,
# merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#########################################
#
# Outputs
#
#########################################

resource "local_file" "driver_variables" {
  filename = "${path.module}/../drivers/aws_resource_names.py"
  content  = <<EOF
SQS_QUEUE_NAME="${aws_sqs_queue.chaos_csv_queue.name}"
S3_BUCKET_NAME="${aws_s3_bucket.chaos_bucket.bucket}"
EOF
}

resource "local_file" "chaos_variables" {
  filename = "${path.module}/../chaos/aws_resource_names.sh"
  content  = <<EOF
#!$(which sh)

SQS_QUEUE_NAME="${aws_sqs_queue.chaos_csv_queue.name}"
SQS_QUEUE_URL="${aws_sqs_queue.chaos_csv_queue.id}"
SNS_TOPIC_NAME="${aws_sns_topic.chaos_topic.name}"
S3_BUCKET_NAME="${aws_s3_bucket.chaos_bucket.bucket}"
LAMBDA_FUNCTION_NAME="${aws_lambda_function.chaos_lambda.function_name}"
AWS_REGION="${data.aws_region.current.name}"

export SQS_QUEUE_NAME SNS_TOPIC_NAME S3_BUCKET_NAME LAMBDA_FUNCTION_NAME AWS_REGION
EOF
}

resource "local_file" "steady_state_flight" {
  filename = "${path.module}/../chaos/steadyStateFlight.json"
  content  = <<EOF
[
    {
        "Id": "pctFlight",
        "Expression": "(((2*sqsInMsgCount) - (ddbWriteCount + sqsOutMsgCount)) / (2*sqsInMsgCount))*100",
        "Label": "PercentInFlight"
    },
    {
        "Id": "sqsInMsgCount",
        "MetricStat": {
            "Metric": {
                "Namespace": "AWS/SQS",
                "MetricName": "NumberOfMessagesSent",
                "Dimensions": [
                    {
                        "Name": "QueueName",
                        "Value": "${aws_sqs_queue.chaos_json_queue.name}"
                    }
                ]
            },
            "Period": 300,
            "Stat": "Sum",
            "Unit": "Count"
        },
        "ReturnData": false
    },
    {
        "Id": "sqsOutMsgCount",
        "MetricStat": {
            "Metric": {
                "Namespace": "AWS/SQS",
                "MetricName": "NumberOfMessagesSent",
                "Dimensions": [
                    {
                        "Name": "QueueName",
                        "Value": "${aws_sqs_queue.chaos_csv_queue.name}"
                    }
                ]
            },
            "Period": 300,
            "Stat": "Sum",
            "Unit": "Count"
        },
        "ReturnData": false
    },
    {
        "Id": "ddbWriteCount",
        "MetricStat": {
            "Metric": {
                "Namespace": "ChaosTransformer",
                "MetricName": "SymbolWriteCount",
                "Dimensions": [
                    {
                        "Name": "DynamoDBTable",
                        "Value": "${aws_dynamodb_table.chaos_data_table.name}"
                    }
                ]
            },
            "Period": 300,
            "Stat": "Sum",
            "Unit": "Count"
        },
        "ReturnData": false
    }
]
EOF
}

resource "local_file" "steady_state_complete" {
  filename = "${path.module}/../chaos/steadyStateComplete.json"
  content  = <<EOF
[
    {
        "Id": "pctComplete",
        "Expression": "(ddbWriteCount / sqsOutMsgCount)*100",
        "Label": "PercentComplete"
    },
    {
        "Id": "sqsInMsgCount",
        "MetricStat": {
            "Metric": {
                "Namespace": "AWS/SQS",
                "MetricName": "NumberOfMessagesSent",
                "Dimensions": [
                    {
                        "Name": "QueueName",
                        "Value": "${aws_sqs_queue.chaos_json_queue.name}"
                    }
                ]
            },
            "Period": 300,
            "Stat": "Sum",
            "Unit": "Count"
        },
        "ReturnData": false
    },
    {
        "Id": "sqsOutMsgCount",
        "MetricStat": {
            "Metric": {
                "Namespace": "AWS/SQS",
                "MetricName": "NumberOfMessagesSent",
                "Dimensions": [
                    {
                        "Name": "QueueName",
                        "Value": "${aws_sqs_queue.chaos_csv_queue.name}"
                    }
                ]
            },
            "Period": 300,
            "Stat": "Sum",
            "Unit": "Count"
        },
        "ReturnData": false
    },
    {
        "Id": "ddbWriteCount",
        "MetricStat": {
            "Metric": {
                "Namespace": "ChaosTransformer",
                "MetricName": "SymbolWriteCount",
                "Dimensions": [
                    {
                        "Name": "DynamoDBTable",
                        "Value": "${aws_dynamodb_table.chaos_data_table.name}"
                    }
                ]
            },
            "Period": 300,
            "Stat": "Sum",
            "Unit": "Count"
        },
        "ReturnData": false
    }
]
EOF
}

resource "local_file" "steady_state_error" {
  filename = "${path.module}/../chaos/steadyStateError.json"
  content  = <<EOF
[
    {
        "Id": "pctError",
        "Expression": "(lambdaErrors / sqsInMsgCount)*100",
        "Label": "PercentInError"
    },
    {
        "Id": "sqsInMsgCount",
        "MetricStat": {
            "Metric": {
                "Namespace": "AWS/SQS",
                "MetricName": "NumberOfMessagesSent",
                "Dimensions": [
                    {
                        "Name": "QueueName",
                        "Value": "${aws_sqs_queue.chaos_json_queue.name}"
                    }
                ]
            },
            "Period": 300,
            "Stat": "Sum",
            "Unit": "Count"
        },
        "ReturnData": false
    },
    {
        "Id": "lambdaErrors",
        "MetricStat": {
            "Metric": {
                "Namespace": "AWS/Lambda",
                "MetricName": "Errors",
                "Dimensions": [
                    {
                        "Name": "FunctionName",
                        "Value": "${aws_lambda_function.chaos_lambda.function_name}"
                    }
                ]
            },
            "Period": 300,
            "Stat": "Sum",
            "Unit": "Count"
        },
        "ReturnData": false
    }
]
EOF
}
