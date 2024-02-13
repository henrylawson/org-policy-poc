terraform {
  backend "gcs" {
    bucket = "hgl-terraform-state-4782"
    prefix = "terraform/state/org-policy-poc"
  }
}