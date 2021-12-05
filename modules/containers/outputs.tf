output "repository_url" {
  value = data.aws_ecr_authorization_token.ecr_token.proxy_endpoint
}

output "ecr_token" {
  value = data.aws_ecr_authorization_token.ecr_token
}