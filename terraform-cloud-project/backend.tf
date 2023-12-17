terraform {
  backend "s3" {
    bucket = "terraform-tony-tf"
    key    = "test-project/backend_cloud-project"
    region = "eu-central-1"
  }
}