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



module "logsink-147374074151-logbucketsink" {
  source  = "terraform-google-modules/log-export/google"
  version = "~> 7.3.0"

  destination_uri      = module.kmiworkplacehub-logging-destination.destination_uri
  log_sink_name        = "147374074151-logbucketsink"
  parent_resource_id   = data.google_folder.fp2d_folder.name
  parent_resource_type = "folder"
  include_children     = true
}

module "kmiworkplacehub-logging-destination" {
  source  = "terraform-google-modules/log-export/google//modules/logbucket"
  version = "~> 7.4.1"

  project_id               = module.logging-md221-il491.project_id
  name                     = "kmiworkplacehub-fp2d-logging"
  location                 = "global"
  retention_days           = 365
  log_sink_writer_identity = module.logsink-147374074151-logbucketsink.writer_identity
}
