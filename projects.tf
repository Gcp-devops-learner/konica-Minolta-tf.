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


resource "random_id" "project" {

  byte_length = 4
}

module "carbon-pride-366804" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name       = "fp2d-prod-Partner-Portal"
  project_id = "carbon-pride-${random_id.project.hex}"
  org_id     = var.org_id
  folder_id  = google_folder.fp2d-production.name
  depends_on = [module.vpc-host-prod-md221-il491]
  svpc_host_project_id  = module.vpc-host-prod-md221-il491.project_id
  shared_vpc_subnets = [for network in module.fp2d-vpc-host-prod.subnets  : network.self_link if network.name == "fp2d-subnet-prod-1"]
  

  billing_account = var.billing_account
}

module "fresh-metrics-366804" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name       = "fp2d-non-prod-Forxai"
  project_id = "fresh-metrics-${random_id.project.hex}"
  org_id     = var.org_id
  folder_id  = google_folder.fp2d-non-production.name
  depends_on = [module.vpc-host-nonprod-md221-il491]
  svpc_host_project_id  = module.vpc-host-nonprod-md221-il491.project_id
  shared_vpc_subnets = [for network in module.fp2d-vpc-host-nonprod.subnets : network.self_link if network.name == "fp2d-subnet-non-prod-1"]
  

  billing_account = var.billing_account
}

module "logging-md221-il491" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name       = "fp2d-logging"
  project_id = "logging-md221-${random_id.project.hex}"
  org_id     = var.org_id
  folder_id  = google_folder.fp2d-common.name

  billing_account = var.billing_account
}

module "monitoring-nonprod-md221-il491" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name       = "fp2d-monitoring-nonprod"
  project_id = "monitoring-nonprod-${random_id.project.hex}"
  org_id     = var.org_id
  folder_id  = google_folder.fp2d-common.name

  billing_account = var.billing_account
}

module "monitoring-prod-md221-il491" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name       = "fp2d-monitoring-prod"
  project_id = "monitoring-prod-${random_id.project.hex}"
  org_id     = var.org_id
  folder_id  = google_folder.fp2d-common.name

  billing_account = var.billing_account
}

module "quiet-being-366804" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name       = "fp2d-non-prod-partner-portal"
  project_id = "quiet-being-${random_id.project.hex}"
  org_id     = var.org_id
  folder_id  = google_folder.fp2d-non-production.name
  depends_on = [module.vpc-host-nonprod-md221-il491]
  svpc_host_project_id  = module.vpc-host-nonprod-md221-il491.project_id
  shared_vpc_subnets = [for network in module.fp2d-vpc-host-nonprod.subnets : network.self_link if network.name == "fp2d-subnet-non-prod-1"]

  billing_account = var.billing_account
}

# Host Project
module "vpc-host-nonprod-md221-il491" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name       = "fp2d-vpc-host-nonprod"
  project_id = "vpc-host-nonprod-${random_id.project.hex}"
  org_id     = var.org_id
  folder_id  = google_folder.fp2d-common.name
  enable_shared_vpc_host_project = true
 

  billing_account = var.billing_account
}

#Host Project

module "vpc-host-prod-md221-il491" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name       = "fp2d-vpc-host-prod"
  project_id = "vpc-host-prod-${random_id.project.hex}"
  org_id     = var.org_id
  folder_id  = google_folder.fp2d-common.name
  enable_shared_vpc_host_project = true
 

  billing_account = var.billing_account
}

module "xenon-blade-366804" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name       = "fp2d-prod-Forxai"
  project_id = "xenon-blade-${random_id.project.hex}"
  org_id     = var.org_id
  folder_id  = google_folder.fp2d-production.name
  depends_on = [module.vpc-host-prod-md221-il491]
  svpc_host_project_id  = module.vpc-host-prod-md221-il491.project_id
  shared_vpc_subnets = [for network in module.fp2d-vpc-host-prod.subnets  : network.self_link if network.name == "fp2d-subnet-prod-1"]

  billing_account = var.billing_account
}