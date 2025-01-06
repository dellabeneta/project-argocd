terraform {
  backend "s3" {
    bucket         = "terraformstates.dellabeneta.tech"
    key            = "project-argocd"
    region         = "sa-east-1"
    encrypt        = true
    dynamodb_table = "terraformstates-lock"
  }
}