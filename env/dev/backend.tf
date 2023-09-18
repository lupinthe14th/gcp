terraform {
  backend "gcs" {
    bucket = "721c10ef92ebaa6a-bucket-tfstate"
    prefix = "gcp/env/dev/terraform.tfstate"
  }
}
