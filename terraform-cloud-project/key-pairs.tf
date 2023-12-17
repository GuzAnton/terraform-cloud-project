resource "aws_key_pair" "cloud-project-key" {
  key_name = "project-key"
  public_key = file(var.PUB_KEY_PATH)
}