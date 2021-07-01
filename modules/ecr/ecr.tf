resource "aws_ecr_repository" "ecr_repo_account" {
  for_each = var.ecr_repo_names
  name = each.value

  image_scanning_configuration {
    scan_on_push = false
  }
}