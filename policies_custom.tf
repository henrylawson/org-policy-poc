# Custom Policy
# https://cloud.google.com/resource-manager/docs/organization-policy/creating-managing-custom-constraints
# https://cloud.google.com/resource-manager/docs/organization-policy/custom-constraint-supported-services
resource "google_org_policy_custom_constraint" "disable_gke_auto_upgrade" {
  name   = "custom.disableGkeAutoUpgrade"
  parent = "organizations/${var.org_id}"

  display_name = "Disable GKE auto upgrade"
  description  = "Only allow GKE NodePool resource to be created or updated if AutoUpgrade is not enabled where this custom constraint is enforced."

  action_type    = "ALLOW"
  condition      = "resource.management.autoUpgrade == false"
  method_types   = ["CREATE", "UPDATE"]
  resource_types = ["container.googleapis.com/NodePool"]
}