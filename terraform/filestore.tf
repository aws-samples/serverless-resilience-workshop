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
# S3 bucket for receiving new data inputs
#
#########################################

resource "aws_s3_bucket" "chaos_bucket" {
  bucket        = "chaos-bucket-${random_id.chaos_stack.hex}"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.chaos_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "chaos_bucket_name" {
  value = aws_s3_bucket.chaos_bucket.id
}

resource "aws_s3_bucket_notification" "chaos_bucket_notifications" {
  bucket = aws_s3_bucket.chaos_bucket.id

  queue {
    queue_arn     = aws_sqs_queue.chaos_json_queue.arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "input/"
    filter_suffix = ".json"
  }

  topic {
    topic_arn     = aws_sns_topic.chaos_topic.arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "output/"
    filter_suffix = ".csv"
  }
}
