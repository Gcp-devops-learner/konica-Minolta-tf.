resource "google_folder" "fp2d-common" {
  display_name = "f2pd-Common"
  parent       = "organizations/${var.org_id}"
}

/*
resource "google_folder" "fp2d" {
  display_name = "FP2D"
  parent       = "organizations/${var.org_id}"
}

resource "google_folder" "fp2d-non-production" {
  display_name = "Non-Production"
  parent       = google_folder.fp2d.name
}

resource "google_folder" "fp2d-production" {
  display_name = "Production"
  parent       = google_folder.fp2d.name
}
*/


data "google_folder" "fp2d_folder" {
  folder              = "folders/342487705408"
  lookup_organization = true
}

resource "google_folder" "fp2d-non-production" {
  display_name = "Non-Production"
  parent       = data.google_folder.fp2d_folder.name
}

resource "google_folder" "fp2d-production" {
  display_name = "Production"
  parent       = data.google_folder.fp2d_folder.name
}