resource "aws_s3_bucket" "bucket" {
  for_each = var.bucket_info
  bucket = each.value["bucket_name"]
  acl    = var.bucket_acl
  policy = <<POLICY
{
  "Version": "${var.bucket_policy.version}",
  "Statement": [
      {
          "Sid": "${var.bucket_policy.sid}",
          "Effect": "${var.bucket_policy.effect}",
          "Principal": "${var.bucket_policy.principal}",
          "Action": "${var.bucket_policy.action}",
          "Resource": "arn:aws:s3:::${each.value["bucket_name"]}/*"
      }
  ]
}
POLICY

  website {
    index_document = var.bucket_static_web.index_doc
    error_document = var.bucket_static_web.error_doc
  }

  cors_rule {
    allowed_origins = ["${each.value["bucket_name"]}.s3-website-${data.aws_region.current.name}.amazonaws.com"]
    allowed_headers = var.bucket_cors.headers
    allowed_methods = var.bucket_cors.methods
    expose_headers  = var.bucket_cors.expose
    max_age_seconds = var.bucket_cors.age
  }

  tags = {
    Name = each.value["tag_name"]
  }
}
