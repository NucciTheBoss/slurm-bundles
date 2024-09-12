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

resource "juju_application" "controller" {
  name  = "controller"
  model = var.model

  charm {
    name     = "slurmctld"
    channel  = var.controller-channel
    revision = var.controller-revision
  }

  units = var.controller-scale
}

resource "juju_application" "compute" {
  name  = "compute"
  model = var.model

  charm {
    name     = "slurmd"
    channel  = var.compute-channel
    revision = var.compute-revision
  }

  units = var.compute-scale
}

resource "juju_application" "database" {
  name  = "database"
  model = var.model

  charm {
    name     = "slurmdbd"
    channel  = var.database-channel
    revision = var.database-revision
  }

  units = var.database-scale
}

resource "juju_application" "database-mysql-router" {
  name  = "database-mysql-router"
  model = var.model

  charm {
    name    = "mysql-router"
    channel = var.mysql-router-channel
  }

  units = var.database-scale
}

resource "juju_application" "rest-api" {
  name  = "rest-api"
  model = var.model

  charm {
    name     = "slurmrestd"
    channel  = var.rest-api-channel
    revision = var.rest-api-revision
  }

  units = var.rest-api-scale
}

resource "juju_integration" "slurmd-to-slurmctld" {
  model = var.model

  application {
    name     = juju_application.compute.name
    endpoint = "slurmctld"
  }

  application {
    name     = juju_application.controller.name
    endpoint = "slurmd"
  }
}

resource "juju_integration" "slurmdbd-to-slurmctld" {
  model = var.model

  application {
    name     = juju_application.database.name
    endpoint = "slurmctld"
  }

  application {
    name     = juju_application.controller.name
    endpoint = "slurmdbd"
  }
}

resource "juju_integration" "mysql-router-to-mysql" {
  model = var.model

  application {
    name     = juju_application.database-mysql-router.name
    endpoint = "backend-database"
  }

  application {
    name     = var.mysql
    endpoint = "database"
  }
}

resource "juju_integration" "slurmdbd-to-mysql-router" {
  model = var.model

  application {
    name     = juju_application.database.name
    endpoint = "database"
  }

  application {
    name     = juju_application.database-mysql-router.name
    endpoint = "database"
  }
}

resource "juju_integration" "slurmrestd-to-slurmctld" {
  model = var.model

  application {
    name     = juju_application.rest-api.name
    endpoint = "slurmctld"
  }

  application {
    name     = juju_application.controller.name
    endpoint = "slurmrestd"
  }
}
