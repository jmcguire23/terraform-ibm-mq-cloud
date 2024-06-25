########################################################################################################################
# Input variables
########################################################################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "Region to provision all resources created by this example"
  default     = "us-south"
}

variable "service_name" {
  type        = string
  description = "The name to give the MQ on Cloud instance."
  default     = "mqcloud"
}

variable "plan_name" {
  type = string
  description = "Name of plan"
  default = "reserved-deployment"
}

variable "prefix" {
  type        = string
  description = "Prefix to append to all resources created by this example"
  default     = "demo"
}

variable "resource_group" {
  type        = string
  description = "The name of an existing resource group to provision resources in to. If not set a new resource group will be created using the prefix variable"
  default     = null
}

variable "existing_mq_capacity_guid" {
  type        = string
  description = "The GUID of an existing capacity service instance"
}

variable "qm_name" {
  type = string
  description = "Name of queue manager"
  default = "QM1"
}

variable "users" {
  description = "List of users to grant access on the queue manager"
  type = list(object({
    name = string
    email = string
  }))
  default = []
}

variable "apps" {
  description = "List of users to grant access on the queue manager"
  type = list(object({
    name = string
  }))
  default = []
}