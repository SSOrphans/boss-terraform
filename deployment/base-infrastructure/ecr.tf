module "ecr" {
  source = "../../modules/ecr"
  
  ecr_repo_names = {
    account     = "ssor-account-repo",
    card        = "ssor-card-repo",
    gateway     = "ssor-gateway-repo",
    transaction = "ssor-transaction-repo",
    user        = "ssor-user-repo",
    loan        = "ssor-loan-repo"
  }
}
