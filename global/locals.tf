locals {
  project_id              = "bigquery-dev-398810"
  predefined_dual_regions = "ASIA1"
  services = toset([                       # Workload Identity Pool
    "iam.googleapis.com",                  # Identity and Access Management (IAM)
    "cloudresourcemanager.googleapis.com", # Cloud Resource Manager API
    "iamcredentials.googleapis.com",       # IAM Service Account Credentials API
    "sts.googleapis.com"                   # Security Token Service API
  ])
  roles = [
    "editor",
  ]
  repo_name = "lupinthe14th/gcp"
}
