variable "bucket_info" {
  type = object({
    bucket_name = string
    acl         = string
    tag_name    = string
  })
  description = "Name for s3 bucket to create and access control list"
}

variable "bucket_static_web" {
  type = object({
    index_doc = string
    error_doc = string
  })
  description = "Specify default and error html page of the website"
}

variable "bucket_policy" {
  type = object({
    version   = string
    sid       = string
    effect    = string
    principal = string
    action    = string
  })
  description = "Policy for S3 bucket"
}

variable "bucket_cors" {
  type = object({
    headers = list(string)
    methods = list(string)
    origins = list(string)
    expose  = list(string)
    age     = number
  })
  description = "CORS configuration for static webpage"
}
