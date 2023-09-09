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



# VPC and Subnets
module "fp2d-vpc-host-nonprod" {
    source  = "terraform-google-modules/network/google"
    version = "~> 5.0"

    project_id   = module.vpc-host-nonprod-md221-il491.project_id
    network_name = "fp2d-vpc-host-nonprod"
    routing_mode = "GLOBAL"

    subnets = [
       
        {
            subnet_name           = "fp2d-subnet-non-prod-1"
            subnet_ip             = "10.200.0.0/24"
            subnet_region         = "europe-west6"
            subnet_private_access = true
            subnet_flow_logs      = true
            subnet_flow_logs_sampling = "0.5"
            subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
            subnet_flow_logs_interval = "INTERVAL_10_MIN"
        },
    ]
    secondary_ranges = {
        fp2d-subnet-non-prod-1= [
            {
                range_name    = "fp2d-subnet-non-prod-1-pod-secondary-range"
                ip_cidr_range = "10.200.1.0/24"
            },
            {
                range_name    = "fp2d-subnet-non-prod-1-service-secondary-range"
                ip_cidr_range = "10.200.2.0/24"
            },
        ]

    }
}
# Firewall Rules
resource "google_compute_firewall" "fp2d-vpc-host-nonprod-allow-iap-rdp" {
  name      = "fp2d-vpc-host-nonprod-allow-iap-rdp"
  network   = module.fp2d-vpc-host-nonprod.network_name
  project   = module.vpc-host-nonprod-md221-il491.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
      metadata = "INCLUDE_ALL_METADATA"
    }

  allow {
    protocol = "tcp"
    ports    = ["3389",]
  }

  source_ranges = [
  "0.0.0.0/0",
  ]
}
resource "google_compute_firewall" "fp2d-vpc-host-nonprod-allow-iap-ssh" {
  name      = "fp2d-vpc-host-nonprod-allow-iap-ssh"
  network   = module.fp2d-vpc-host-nonprod.network_name
  project   = module.vpc-host-nonprod-md221-il491.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
      metadata = "INCLUDE_ALL_METADATA"
    }

  allow {
    protocol = "tcp"
    ports    = ["22",]
  }

  source_ranges = [
  "0.0.0.0/0",
  ]
}
resource "google_compute_firewall" "fp2d-vpc-host-nonprod-allow-icmp" {
  name      = "fp2d-vpc-host-nonprod-allow-icmp"
  network   = module.fp2d-vpc-host-nonprod.network_name
  project   = module.vpc-host-nonprod-md221-il491.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
      metadata = "INCLUDE_ALL_METADATA"
    }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
  "0.0.0.0/0",
  ]
}
# NAT Router and config

# VPC and Subnets
module "fp2d-vpc-host-prod" {
    source  = "terraform-google-modules/network/google"
    version = "~> 5.0"

    project_id   = module.vpc-host-prod-md221-il491.project_id
    network_name = "fp2d-vpc-host-prod"
    routing_mode = "GLOBAL"

    subnets = [
       
        {
            subnet_name           = "fp2d-subnet-prod-1"
            subnet_ip             = "10.200.3.0/24"
            subnet_region         = "europe-west6"
            subnet_private_access = true
            subnet_flow_logs      = true
            subnet_flow_logs_sampling = "0.5"
            subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
            subnet_flow_logs_interval = "INTERVAL_10_MIN"
        },
    ]

    secondary_ranges = {
        fp2d-subnet-prod-1= [
            {
                range_name    = "fp2d-subnet-prod-1-pod-secondary-range"
                ip_cidr_range = "10.200.4.0/24"
            },
            {
                range_name    = "fp2d-subnet-prod-1-service-secondary-range"
                ip_cidr_range = "10.200.5.0/24"
            },
        ]

    }
}
# Firewall Rules
resource "google_compute_firewall" "fp2d-vpc-host-prod-allow-iap-rdp" {
  name      = "fp2d-vpc-host-prod-allow-iap-rdp"
  network   = module.fp2d-vpc-host-prod.network_name
  project   = module.vpc-host-prod-md221-il491.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
      metadata = "INCLUDE_ALL_METADATA"
    }

  allow {
    protocol = "tcp"
    ports    = ["3389",]
  }

  source_ranges = [
  "0.0.0.0/0",
  ]
}
resource "google_compute_firewall" "fp2d-vpc-host-prod-allow-iap-ssh" {
  name      = "fp2d-vpc-host-prod-allow-iap-ssh"
  network   = module.fp2d-vpc-host-prod.network_name
  project   = module.vpc-host-prod-md221-il491.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
      metadata = "INCLUDE_ALL_METADATA"
    }

  allow {
    protocol = "tcp"
    ports    = ["22",]
  }

  source_ranges = [
  "0.0.0.0/0",
  ]
}
resource "google_compute_firewall" "fp2d-vpc-host-prod-allow-icmp" {
  name      = "fp2d-vpc-host-prod-allow-icmp"
  network   = module.fp2d-vpc-host-prod.network_name
  project   = module.vpc-host-prod-md221-il491.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
      metadata = "INCLUDE_ALL_METADATA"
    }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
  "0.0.0.0/0",
  ]
}
# NAT Router and config

