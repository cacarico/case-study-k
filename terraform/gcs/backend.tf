terraform {
  backend "gcs" {
    bucket = "820e982ac6c1d0cc-tfstate"
    prefix = "terraform/state"
  }
}
