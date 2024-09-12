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

variable "model" {
  description = "Juju model to deploy operators within"
  type        = string
}

variable "controller-scale" {
  description = "Scale of slurmctld (controller) deployment"
  type        = number
  default     = 1
}

variable "controller-channel" {
  description = "slurmctld operator channel"
  type        = string
  default     = "latest/edge"
}

variable "controller-revision" {
  description = "slurmctld operator channel revision"
  type        = string
  default     = null
}

variable "compute-scale" {
  description = "Scale of slurmd (compute) deployment"
  type        = number
  default     = 1
}

variable "compute-channel" {
  description = "slurmd operator channel"
  type        = string
  default     = "latest/edge"
}

variable "compute-revision" {
  description = "slurmd operator channel revision"
  type        = string
  default     = null
}

variable "database-scale" {
  description = "Scale of slurmdbd (database) deployment"
  type        = number
  default     = 1
}

variable "database-channel" {
  description = "slurmdbd operator channel"
  type        = string
  default     = "latest/edge"
}

variable "database-revision" {
  description = "slurmdbd operator channel revision"
  type        = string
  default     = null
}

variable "mysql-router-channel" {
  description = "mysql router operator channel"
  type        = string
  default     = "dpe/beta"
}

variable "mysql" {
  description = "mysql operator to integrate with"
  type        = string
}

variable "rest-api-scale" {
  description = "Scale of slurmrestd (REST API) deployment"
  type        = number
  default     = 1
}

variable "rest-api-channel" {
  description = "slurmrestd operator channel"
  type        = string
  default     = "latest/edge"
}

variable "rest-api-revision" {
  description = "slurmrestd operator channel revision"
  type        = string
  default     = null
}
