module "s3" {
  source            = "../../modules/s3"
  bucket_info       = var.bucket_info
  bucket_static_web = var.bucket_static_web
  bucket_policy     = var.bucket_policy
  bucket_cors       = var.bucket_cors
}
