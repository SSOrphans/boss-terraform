bucket_info = {
  bucket_name = "www.boss-ssor"
  acl         = "public-read"
  tag_name    = "public-ui"
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
  origins = ["www.boss-ssor.s3-website-us-west-1.amazonaws.com"]
  expose  = ["ETag"]
  age     = 1800
}
