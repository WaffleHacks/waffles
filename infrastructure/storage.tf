/*
  Remote storage locations (S3, GCS, etc)
*/

resource "aws_s3_bucket" "cms" {
  bucket = "wafflehacks-cms"
  acl    = "public-read"

  tags = {
    service = "cms"
  }
}
