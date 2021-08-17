module "s3" {
  source = "../../modules/s3"

  bucket_info = {
    public_ui = {
      bucket_name = "www.bankofsmoothstack.com"
      tag_name    = "public-ui-portal"
    },
    admin_ui = {
      bucket_name = "admin.bankofsmoothstack.com"
      tag_name    = "admin-ui-portal"
    }
  }

  bucket_static_web = {
    index_doc = "index.html"
    error_doc = "index.html"
  }

  bucket_policy = {
    version   = "2008-10-17"
    sid       = "1"
    effect    = "Allow"
    principal = "*"
    action    = "s3:GetObject"
  }

  bucket_cors = {
    headers = ["*"]
    methods = ["GET", "PUT", "POST", "DELETE"]
    expose  = ["ETag"]
    age     = 1800
  }

  bucket_acl = "public-read"
}
