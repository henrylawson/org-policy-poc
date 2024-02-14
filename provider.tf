variable "quota_project_id" {
  type    = string
  default = "hgl-env-a"
}

provider "google" {
  user_project_override = true
  billing_project       = var.quota_project_id
}

provider "google-beta" {
  user_project_override = true
  billing_project       = var.quota_project_id
}