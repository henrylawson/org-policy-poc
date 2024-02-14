resource "google_project_service" "org_policy" {
  project = var.quota_project_id
  service = "orgpolicy.googleapis.com"
}

