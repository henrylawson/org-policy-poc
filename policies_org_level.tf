# Documentation:
# https://github.com/terraform-google-modules/terraform-google-org-policy/tree/v5.3.0/modules/org_policy_v2

# Force OS Login
module "org_require_os_login" {
  source     = "terraform-google-modules/org-policy/google//modules/org_policy_v2"
  version    = "~> 5.3.0"
  depends_on = [google_project_service.org_policy]

  constraint  = "compute.requireOsLogin"
  policy_type = "boolean"

  policy_root    = "organization"
  policy_root_id = var.org_id

  rules = [{
    enforcement = true
    allow       = []
    deny        = []
    conditions  = []
  }]

  exclude_folders  = []
  exclude_projects = []
}

# Restrict certain locations only
# https://cloud.google.com/resource-manager/docs/organization-policy/defining-locations-supported-services
module "org_require_resource_locations" {
  source     = "terraform-google-modules/org-policy/google//modules/org_policy_v2"
  version    = "~> 5.3.0"
  depends_on = [google_project_service.org_policy]

  constraint  = "gcp.resourceLocations"
  policy_type = "list"

  policy_root    = "organization"
  policy_root_id = var.org_id

  rules = [{
    enforcement = null
    allow = [
      "in:us-central1-locations",
      "in:australia-southeast1-locations",
      "in:australia-southeast2-locations"
    ]
    deny       = []
    conditions = []
  }]

  exclude_folders  = []
  exclude_projects = []
}

# Restrict certain services only
# https://cloud.google.com/resource-manager/docs/organization-policy/restricting-resources-supported-services
module "org_require_resource_services" {
  source     = "terraform-google-modules/org-policy/google//modules/org_policy_v2"
  version    = "~> 5.3.0"
  depends_on = [google_project_service.org_policy]

  constraint  = "gcp.restrictServiceUsage"
  policy_type = "list"

  policy_root    = "organization"
  policy_root_id = var.org_id

  rules = [{
    enforcement = null
    allow       = []
    deny = [
      "file.googleapis.com",
    ]
    conditions = []
  }]

  exclude_folders = []
  exclude_projects = [
    "hgl-env-kilo-non-prod"
  ]
}

# Use a custom defined org policy
module "org_require_disable_gke_auto_upgrade" {
  source     = "terraform-google-modules/org-policy/google//modules/org_policy_v2"
  version    = "~> 5.3.0"
  depends_on = [google_project_service.org_policy]

  constraint  = google_org_policy_custom_constraint.disable_gke_auto_upgrade.name
  policy_type = "boolean"

  policy_root    = "organization"
  policy_root_id = var.org_id

  rules = [{
    enforcement = true
    allow       = []
    deny        = []
    conditions  = []
  }]

  exclude_folders  = []
  exclude_projects = []
}