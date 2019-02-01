terraform {
  backend "gcs" {
    bucket = "storage-tfstate-prod"
  }
}
