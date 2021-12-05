resource "aws_ecr_repository" "test_project" {
  name = "test_project"

}

data "aws_ecr_authorization_token" "ecr_token" {
}