########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.1.6"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

########################################################################################################################
# MQ on Cloud
########################################################################################################################

module "mqcloud_instance" {
  source                    = "../../modules/mq-instance"
  name                      = "${var.prefix}-mq-demo-instance"
  region                    = var.region
  resource_group_id         = module.resource_group.resource_group_id
  existing_mq_capacity_crn  = var.existing_mq_capacity_crn
}

module "queue_manager" {
  source                = "../../modules/queue-manager"
  display_name          = "This Queue Manager was deployed using Terraform"
  location              = module.mqcloud_instance.queue_manager_options.locations[0]
  name                  = "${var.qm_name}"
  service_instance_crn  = module.mqcloud_instance.deployment_crn
  size                  = "xsmall"
  queue_manager_version = module.mqcloud_instance.queue_manager_options.latest_version
}

##############################################################################
# MQ on Cloud applications
##############################################################################
module "mqcloud_app" {
  for_each = {
    for index, app in var.apps:
    app.name => app
  }
  source                = "../../modules/application"
  service_instance_crn = module.mqcloud_instance.deployment_crn
  name = each.value.name
}


##############################################################################
# MQ on Cloud users
##############################################################################
module "mqcloud_user" {
  for_each = {
    for index, user in var.users:
    user.name => user
  }
  source                = "../../modules/user"
  service_instance_crn = module.mqcloud_instance.deployment_crn
  name = each.value.name
  email = each.value.email
}
