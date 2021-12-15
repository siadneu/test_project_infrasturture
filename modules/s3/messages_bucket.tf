resource "aws_s3_bucket" "testprojectmessages" {
  bucket        = "testprojectmessages"
  force_destroy = true
  versioning {
    enabled = true
    mfa_delete = false
  }
}