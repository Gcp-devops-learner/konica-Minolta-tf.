/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */



module "fp2d-production-iam" {
  source  = "terraform-google-modules/iam/google//modules/folders_iam"
  version = "~> 7.4"

  folders = [google_folder.fp2d-production.name]

  bindings = {
    
    "roles/compute.instanceAdmin.v1" = [
      "group:gcp-fp2d-admin@kmiworkplacehub.com",
    ]
    
    
  }
}


module "fp2d-non-production-iam" {
  source  = "terraform-google-modules/iam/google//modules/folders_iam"
  version = "~> 7.4"

  folders = [google_folder.fp2d-non-production.name]

  bindings = {
    
    "roles/compute.instanceAdmin.v1" = [
      "group:gcp-fp2d-developers@kmiworkplacehub.com",
    ]
    
    
    
  }
}
