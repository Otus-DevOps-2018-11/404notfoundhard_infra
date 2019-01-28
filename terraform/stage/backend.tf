terraform {
  backend "gcs" {
    bucket = "storage-tfstate-stage"
  }
}
