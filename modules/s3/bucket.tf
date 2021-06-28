resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_info.bucket_name
  acl    = var.bucket_info.acl
  policy = <<POLICY
{
  "Version": "${var.bucket_policy.version}",
  "Statement": [
      {
          "Sid": "${var.bucket_policy.sid}",
          "Effect": "${var.bucket_policy.effect}",
          "Principal": "${var.bucket_policy.principal}",
          "Action": "${var.bucket_policy.action}",
          "Resource": "arn:aws:s3:::${var.bucket_info.bucket_name}/*"
      }
  ]
}
POLICY

  website {
    index_document = var.bucket_static_web.index_doc
    error_document = var.bucket_static_web.error_doc
  }

  cors_rule {
    allowed_headers = var.bucket_cors.headers
    allowed_methods = var.bucket_cors.methods
    allowed_origins = var.bucket_cors.origins
    expose_headers  = var.bucket_cors.expose
    max_age_seconds = var.bucket_cors.age
  }

  tags = {
    Name = var.bucket_info.tag_name
  }
}
