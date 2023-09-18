resource "google_project_service" "enable_api" {
  for_each = local.services

  project                    = data.google_project.this.project_id
  service                    = each.value
  disable_dependent_services = true
}

# Service account associated with workload identity pool
resource "google_service_account" "github-svc" {
  project      = data.google_project.this.project_id
  account_id   = "github-actions-svc"
  display_name = "github-actions runner"
  description  = "Service account for github actions runner"
}

resource "google_project_iam_member" "github-svc" {
  for_each = { for role in local.roles : role => role }

  project = data.google_project.this.project_id
  role    = "roles/${each.value}"
  member  = "serviceAccount:${google_service_account.github-svc.email}"
}

# create workload id pool and provider
module "gh_oidc" {
  source  = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version = "~> 3.0"

  project_id  = data.google_project.this.project_id
  pool_id     = "github-actions-pool"
  provider_id = "github-actions-oidc"
  sa_mapping = {
    "github-actions" = {
      sa_name   = google_service_account.github-svc.name,
      attribute = "attribute.repository/${local.repo_name}",
    }
  }
}
