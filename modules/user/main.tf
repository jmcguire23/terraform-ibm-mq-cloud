##############################################################################
# terraform-ibm-mq-cloud
#
# Create an MQ on Cloud user
##############################################################################

locals {
  # Deployment service instance
  split_deployment_crn        = split(":", var.service_instance_crn)
  existing_mq_deployment_guid = length(local.split_deployment_crn) >= 8 ? local.split_deployment_crn[7] : null
}

resource "ibm_mqcloud_user" "user" {
  email                 = var.email
  name                  = var.name
  service_instance_guid = local.existing_mq_deployment_guid
}
