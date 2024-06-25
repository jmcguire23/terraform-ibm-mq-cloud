########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.1.5"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

########################################################################################################################
# MQ on Cloud
########################################################################################################################

module "mqcloud_instance" {
  source                    = "../../modules/mq-instance"
  name                      = "${var.prefix}-mq-instance"
  region                    = var.region
  service_name              = var.service_name
  resource_group_id         = module.resource_group.resource_group_id
  existing_mq_capacity_guid = var.existing_mq_capacity_guid
  plan_name                 = var.plan_name
}

module "queue_manager" {
  source                = "../../modules/queue-manager"
  display_name          = "${var.prefix}-qm-display-name"
  location              = module.mqcloud_instance.queue_manager_options.locations[0]
  name                  = var.qm_name
  service_instance_guid = module.mqcloud_instance.deployment_guid
  size                  = "xsmall"
  queue_manager_version = module.mqcloud_instance.queue_manager_options.latest_version
}
module "mqcloud_user" {
  for_each = {
    for index, user in var.users:
    user.name => user
  }
  source                = "../../modules/user"
  service_instance_guid = module.mqcloud_instance.deployment_guid
  name = each.value.name
  email = each.value.email
}

module "mqcloud_app" {
  for_each = {
    for index, app in var.apps:
    app.name => app
  }
  source                = "../../modules/application"
  service_instance_guid = module.mqcloud_instance.deployment_guid
  name = each.value.name
}
