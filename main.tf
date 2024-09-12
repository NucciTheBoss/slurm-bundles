# Copyright 2024 Canonical Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

terraform {
  required_providers {
    juju = {
      source  = "juju/juju"
      version = "0.13.0"
    }
  }
}

provider "juju" {}

resource "juju_model" "charmed-hpc" {
  name = var.model

  cloud {
    name   = var.cloud
    region = "localhost"
  }

  credential = var.credential
  config     = var.config
}

module "mysql" {
  source  = "./modules/mysql"
  model   = var.model
  scale   = 1
  channel = "8.0/stable"
}

module "slurm" {
  depends_on         = [module.mysql]
  source             = "./modules/slurm"
  model              = var.model
  controller-scale   = 1
  controller-channel = "latest/edge"
  compute-scale      = 1
  compute-channel    = "latest/edge"
  database-scale     = 1
  database-channel   = "latest/edge"
  mysql              = "mysql"
  rest-api-scale     = 1
  rest-api-channel   = "latest/edge"
}
